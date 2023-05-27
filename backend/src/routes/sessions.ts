/**
 * This file contains the route that will create a session
 */

import express, { NextFunction, Request, Response } from "express";
import mongoose, { ObjectId } from "mongoose";
import schedule from "node-schedule";
// import { boolean } from "caketype";
import { createPreSessionNotes, createPostSessionNotes } from "../services/note";
import { verifyAuthToken } from "../middleware/auth";
import { validateReqBodyWithCake } from "../middleware/validation";
import { Mentor, Mentee, Session } from "../models";
import { CreateSessionRequestBodyCake } from "../types/cakes";
import { InternalError, ServiceError } from "../errors";
import { getCalendlyEventDate } from "../services/calendly";
import { getMentorId } from "../services/user";
import { sendNotification } from "../services/notifications";

/**
 * This is a post route to create a new session. 
 *
 * Session: {
 preSession: string;
 postSession: string;
 menteeId: string;
 mentorId: string;
 calendlyURI: string;
}

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
      if (!mentee) {
        throw ServiceError.MENTEE_WAS_NOT_FOUND;
      }
      const mentorId = await getMentorId(mentee.pairingId);
      const mentor = await Mentor.findById(mentorId);
      if (!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }
      const accessToken = mentor.personalAccessToken;
      const data = await getCalendlyEventDate(req.body.calendlyURI, accessToken);
      const session = new Session({
        preSession: null,
        postSessionMentee: null,
        postSessionMentor: null,
        menteeId: uid,
        mentorId,
        missedSessionReason: null,
        startTime: data.resource.start_time,
        endTime: data.resource.end_time,
        calendlyUri: req.body.calendlyURI,
        preSessionCompleted: false,
        postSessionMentorCompleted: false,
        postSessionMenteeCompleted: false,
      });
      const sessionId = session._id;
      const preNoteId = await createPreSessionNotes(sessionId);
      const postMenteeNoteId = await createPostSessionNotes(sessionId, "postMentee");
      const postMentorNoteId = await createPostSessionNotes(sessionId, "postMentor");
      session.preSession = preNoteId._id;
      session.postSessionMentee = postMenteeNoteId._id;
      session.postSessionMentor = postMentorNoteId._id;
      await session.save();

      const job = schedule.scheduleJob("*/1 * * * *", async () => {
        try {
          const result = await sendNotification(
            "New session booked!",
            "You have a new session with " +
              mentee.name +
              ". Check out your session details \u{1F60E}",
            "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M"
          );
          console.log("Function executed successfully:", result);
        } catch (error) {
          console.error("Error executing function:", error);
        }
      });
      console.log(job);
      
      /*
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
      */
      return res.status(201).json({
        sessionId: session._id,
        mentorId: session.mentorId,
        menteeId: session.menteeId,
      });
    } catch (e) {
      next();
      return res.status(400).json({
        error: e,
      });
    }
  }
);

router.get(
  "/sessions/:sessionId",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const sessionId = req.params.sessionId;
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

      if (!mongoose.Types.ObjectId.isValid(sessionId)) {
        throw ServiceError.INVALID_MONGO_ID;
      }

      const session = await Session.findById(sessionId);
      if (!session) {
        throw ServiceError.SESSION_WAS_NOT_FOUND;
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
      } = session;
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
          startTime,
          endTime,
          day: dayNames[startTime.getDay()],
          preSessionCompleted,
          postSessionMenteeCompleted,
          postSessionMentorCompleted,
          hasPassed,
        },
      });
    } catch (e) {
      return next(e instanceof ServiceError ? e : InternalError.ERROR_GETTING_SESSION);
    }
  }
);

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
        userSessions = await Session.find({ menteeId: { $eq: userID } });
      } else {
        // role = "mentor"
        userSessions = await Session.find({ mentorId: { $eq: userID } });
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

export { router as sessionsRouter };
