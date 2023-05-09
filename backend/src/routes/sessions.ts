/**
 * This file contains the route that will create a session
 */

import express, { NextFunction, Request, Response } from "express";
import mongoose from "mongoose";
import { Session } from "../models/session";
import { createPreSessionNotes, createPostSessionNotes } from "../services/note";
import { InternalError } from "../errors/internal";
import { ServiceError } from "../errors/service";
import { validateReqBodyWithCake } from "../middleware/validation";
import { verifyAuthToken } from "../middleware/auth";
import { CreateSessionRequestBodyCake } from "../types/cakes";
import { getCalendlyEventDate } from "../services/calendly";
import { Mentor } from "../models/mentor";
import { Mentee } from "../models/mentee";
import { getMentorId } from "../services/user";

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
    console.info("Posting new session,");
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
      return res.status(201).json({
        sessionId: session._id,
        mentorId: session.mentorId,
        menteeId: session.menteeId,
      });
    } catch (e) {
      console.log(e);
      next(e);
      return res.status(400);
    }
  }
);

router.get(
  "/sessions/:sessionId",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const sessionId = req.params.sessionId;

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
        menteeId,
        mentorId,
        startTime,
        endTime,
        preSessionCompleted,
        postSessionMenteeCompleted,
        postSessionMentorCompleted,
      } = session;
      return res.status(200).send({
        message: `Here is session ${sessionId}`,
        session: {
          preSession,
          postSessionMentee,
          postSessionMentor,
          menteeId,
          mentorId,
          startTime,
          endTime,
          preSessionCompleted,
          postSessionMenteeCompleted,
          postSessionMentorCompleted,
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
      if (role === null || userID === null) {
        throw InternalError.ERROR_GETTING_SESSION;
      }

      if (role === "mentee") {
        userSessions = await Session.find({ menteeId: { $eq: userID } });
      }
      if (role === "mentor") {
        userSessions = await Session.find({ mentorId: { $eq: userID } });
      }
      if (userSessions === null) {
        return res.status(400).json({
          message: `No sessions found for user ${userID}!`,
        });
      }
      return res.status(200).json({
        message: `Sessions for user ${userID}:`,
        sessions: userSessions,
      });
    } catch (e) {
      console.log(e);
      next();
      return res.status(400);
    }
  }
);

export { router as sessionsRouter };
