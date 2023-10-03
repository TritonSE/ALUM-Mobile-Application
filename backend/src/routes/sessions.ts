/**
 * This file contains routes pertaining to sessions
 */

import express, { NextFunction, Request, Response } from "express";
import mongoose, { ObjectId } from "mongoose";
// import schedule from "node-schedule";
// import { boolean } from "caketype";
import { validateReqBodyWithCake } from "../middleware/validation";
import { Mentor, Mentee, Session } from "../models";
import { CreateSessionRequestBodyCake } from "../types";
import { verifyAuthToken } from "../middleware/auth";
import { getCalendlyEventDate, deleteCalendlyEvent } from "../services/calendly";
import { createPreSessionNotes, createPostSessionNotes, deleteNotes } from "../services/note";
import { getMentorId } from "../services/user";
import { sendNotification } from "../services/notifications";
import { InternalError, ServiceError } from "../errors";
import { formatDateTimeRange } from "../services/session";

/**
This is a post route to create a new session. 
IMPORTANT: Date should be passed in with the format:
"YYYY-MM-DDTHH-MM-SS", where 
Y=>year
M=>month
D=>day
H=>Hour
M=>Minute
S=>Seconds
For example: "1995-12-17T03:24:00"
*/

const router = express.Router();

router.post(
  "/sessions",
  [validateReqBodyWithCake(CreateSessionRequestBodyCake), verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const { uid } = req.body;
      const mentee = await Mentee.findById(uid);
      const menteeMongoId = new mongoose.Types.ObjectId(uid);
      if (!mentee) {
        throw ServiceError.MENTEE_WAS_NOT_FOUND;
      }
      const mentorId = await getMentorId(mentee.pairingId);
      const mentorMongoId = new mongoose.Types.ObjectId(mentorId);
      const mentor = await Mentor.findById(mentorId);
      if (!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }
      const accessToken = mentor.personalAccessToken;
      const data = await getCalendlyEventDate(req.body.calendlyURI, accessToken);
      const startDate = new Date(2023, 0O5, 0O5, 17, 0, 0, 0);  
      const endDate = new Date(2023, 0O5, 0O5, 18, 0, 0, 0);  

      const session = new Session({
        preSession: null,
        postSessionMentee: null,
        postSessionMentor: null,
        menteeId: menteeMongoId,
        mentorId: mentorMongoId,
        missedSessionReason: null,
        startTime: data.resource?.start_time ?? startDate,
        endTime: data.resource?.end_time ?? endDate,
        calendlyUri: req.body.calendlyURI,
        preSessionCompleted: false,
        postSessionMentorCompleted: false,
        postSessionMenteeCompleted: false,
        upcomingSessionNotifSent: false,
        postSessionNotifSent: false,
      });
      const sessionId = session._id;
      const preNoteId = await createPreSessionNotes(sessionId);
      const postMenteeNoteId = await createPostSessionNotes(sessionId, "postMentee");
      const postMentorNoteId = await createPostSessionNotes(sessionId, "postMentor");
      session.preSession = preNoteId._id;
      session.postSessionMentee = postMenteeNoteId._id;
      session.postSessionMentor = postMentorNoteId._id;
      await session.save();
      
      await sendNotification(
        "New session booked!",
        "You have a new session with " + mentee.name + ". Check out your session details \u{1F60E}",
        mentor.fcmToken
      );
      await sendNotification(
        "New session booked!",
        "You have a new session with " +
          mentor.name +
          ". Fill out your pre-session notes now \u{1F60E}",
        mentee.fcmToken
      );
      
      return res.status(201).json({
        sessionId: session._id,
        mentorId: session.mentorId,
        menteeId: session.menteeId,
      });
    } catch (e) {
      next();
      console.log(e);
      return res.status(400).json({
        error: e,
      });
    }
  }
);

/**
 * This route returns a Session body when given param
 * sessionId
 */
router.get(
  "/sessions/:sessionId",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const sessionId = req.params.sessionId;
      const dateNow = new Date();

      // Find session document
      if (!mongoose.Types.ObjectId.isValid(sessionId)) {
        throw ServiceError.INVALID_MONGO_ID;
      }

      const session = await Session.findById(sessionId);
      if (!session) {
        throw ServiceError.SESSION_WAS_NOT_FOUND;
      }

      // Find mentor document for the location
      const mentor = await Mentor.findById(session.mentorId);
      if (!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }

      // Find mentee document for the location
      const mentee = await Mentee.findById(session.menteeId);
      if (!mentee) {
        throw ServiceError.MENTEE_WAS_NOT_FOUND;
      }

      const {
        preSession,
        postSessionMentee,
        postSessionMentor,
        missedSessionReason,
        menteeId,
        mentorId,
        startTime,
        endTime,
        preSessionCompleted,
        postSessionMenteeCompleted,
        postSessionMentorCompleted,
        upcomingSessionNotifSent,
        postSessionNotifSent,
      } = session;
      const [fullDateString, dateShortHandString, startTimeString, endTimeString] =
        formatDateTimeRange(startTime, endTime);

      const hasPassed = dateNow.getTime() - endTime.getTime() > 0;

      return res.status(200).send({
        message: `Here is session ${sessionId}`,
        session: {
          preSession,
          postSessionMentee,
          postSessionMentor,
          missedSessionReason,
          menteeId,
          mentorId,
          menteeName: mentee.name,
          mentorName: mentor.name,
          fullDateString,
          dateShortHandString,
          startTimeString,
          endTimeString,
          preSessionCompleted,
          postSessionMenteeCompleted,
          postSessionMentorCompleted,
          hasPassed,
          upcomingSessionNotifSent,
          postSessionNotifSent,
          location: mentor.location,
        },
      });
    } catch (e) {
      return next(e instanceof ServiceError ? e : InternalError.ERROR_GETTING_SESSION);
    }
  }
);

/**
 * This route returns all the sessions a user has
 */
router.get(
  "/sessions",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userID = req.body.uid;
      const role = req.body.role;
      let userSessions;
      const dayNames = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
      ];
      const dateNow = new Date();
      if (role === null || userID === null) {
        throw InternalError.ERROR_GETTING_SESSION;
      }

      if (role === "mentee") {
        userSessions = await Session.find({ menteeId: userID }).exec();
        console.log(userID);
        console.log(userSessions);
      } else {
        // role = "mentor"
        userSessions = await Session.find({ mentorId: userID }).exec();
        console.log(userID);
        console.log(userSessions);
      }
      if (userSessions === null) {
        return res.status(400).json({
          message: `No sessions found for user ${userID}!`,
        });
      }
      const sessionsArray: {
        id: ObjectId;
        startTime: Date;
        endTime: Date;
        day: string;
        preSessionCompleted: boolean;
        postSessionCompleted: boolean;
        title: string;
        hasPassed: boolean;
      }[] = [];
      userSessions.forEach((session) => {
        const {
          startTime,
          endTime,
          preSessionCompleted,
          postSessionMenteeCompleted,
          postSessionMentorCompleted,
        } = session;
        const hasPassed = dateNow.getTime() - endTime.getTime() > 0;
        if (role === "mentor") {
          sessionsArray.push({
            id: session._id,
            startTime,
            endTime,
            day: dayNames[startTime.getDay()],
            preSessionCompleted,
            postSessionCompleted: postSessionMentorCompleted,
            title: "Session with Mentee",
            hasPassed,
          });
        } else {
          sessionsArray.push({
            id: session._id,
            startTime,
            endTime,
            day: dayNames[startTime.getDay()],
            preSessionCompleted,
            postSessionCompleted: postSessionMenteeCompleted,
            title: "Session with Mentor",
            hasPassed,
          });
        }
      });
      return res.status(200).json({
        message: `Sessions for user ${userID}:`,
        sessions: sessionsArray,
      });
    } catch (e) {
      console.log(e);
      next();
      return res.status(400);
    }
  }
);

/**
 * This route updates a session time. Note that it does not edit
 * other elements of a session (notes)
 */
router.patch(
  "/sessions/:sessionId",
  [validateReqBodyWithCake(CreateSessionRequestBodyCake), verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    console.log("Updating a session");
    try {
      const sessionId = req.params.sessionId;
      const newCalendlyURI = req.body.calendlyURI;
      const currSession = await Session.findById(sessionId);
      if (!currSession) {
        throw InternalError.ERROR_GETTING_SESSION;
      }
      const oldCalendlyURI = currSession.calendlyUri;
      const mentor = await Mentor.findById(currSession.mentorId);
      if (!mentor) {
        throw InternalError.ERROR_GETTING_MENTOR;
      }
      const mentee = await Mentee.findById(currSession.menteeId);
      if (!mentee) {
        throw InternalError.ERROR_GETTING_MENTEE;
      }
      const personalAccessToken = mentor.personalAccessToken;
      await deleteCalendlyEvent(oldCalendlyURI, personalAccessToken);
      const newEventData = await getCalendlyEventDate(newCalendlyURI, personalAccessToken);
      const updates = {
        startTime: newEventData.resource.start_time,
        endTime: newEventData.resource.end_time,
        calendlyUri: newCalendlyURI,
      };
      await Session.findByIdAndUpdate(sessionId, { $set: updates }, { new: true });
      await sendNotification(
        "A session has been rescheduled",
        "Your upcoming session with " + mentor.name + " has been rescheduled! Check out your new session details.",
        mentee.fcmToken
      )
      await sendNotification(
        "A session has been rescheduled",
        "" + mentee.name + " has rescheduled your upcoming session! Check out your session details.",
        mentor.fcmToken
      )
      return res.status(200).json({
        message: "Successfuly updated the session!",
      });
    } catch (e) {
      console.log(e);
      next();
      return res.status(400);
    }
  }
);

/**
 * This route deletes a session and all components associated with it
 * (pre and post session notes)
 */
router.delete(
  "/sessions/:sessionId",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    console.log("Deleting a session");
    const role = req.body.role;
    const sessionId = req.params.sessionId;
    const session = await Session.findById(sessionId);
    if (!session) throw ServiceError.SESSION_WAS_NOT_FOUND;
    const uri = session.calendlyUri;
    const mentor = await Mentor.findById(session.mentorId);
    if (!mentor) throw ServiceError.MENTOR_WAS_NOT_FOUND;
    const personalAccessToken = mentor.personalAccessToken;
    const mentee = await Mentee.findById(session.menteeId);
    if (!mentee) throw ServiceError.MENTEE_WAS_NOT_FOUND;
    try {
      deleteCalendlyEvent(uri, personalAccessToken);
      await deleteNotes(session.preSession, session.postSessionMentee, session.postSessionMentor);
      await Session.findByIdAndDelete(sessionId);
      if (role === "mentee") {
        await sendNotification(
          "A session has been cancelled.",
          "Your session with " + mentor.name + " has been cancelled.",
          mentee.fcmToken
        )
        await sendNotification(
          "A session has been cancelled.",
          "" + mentee.name + " has cancelled your upcoming session.",
          mentor.fcmToken
        )
      } else if (role  === "mentor") {
        await sendNotification(
          "A session has been cancelled.",
          "Your session with " + mentee.name + " has been cancelled.",
          mentor.fcmToken
        )
        await sendNotification (
          "A session has been cancelled.",
          "" + mentor.name + " has cancelled your upcoming session. \u{1F494} Reschedule to save your pre-session notes.",
          mentee.fcmToken
        )
      }
      return res.status(200).json({
        message: "calendly successfully cancelled, notes deleted, session deleted.",
      });
    } catch (e) {
      console.log(e);
      next();
      return res.status(400);
    }
  }
);

export { router as sessionsRouter };
