/**
 * This file contains the route that will create a session
 */

import express, { NextFunction, Request, Response } from "express";
import mongoose from "mongoose";
import { Session } from "../models/session";
import { createPreSessionNotes, createPostSessionNotes } from "../services/note";
import { verifyAuthToken } from "../middleware/auth";
import { ServiceError } from "../errors/service";
import { InternalError } from "../errors/internal";
import { validateReqBodyWithCake } from "../middleware/validation";
import { CreateSessionRequestBodyCake } from "../types/cakes";

/**
 * This is a post route to create a new session. 
 *
 * Session: {
 preSession: string;
 postSession: string;
 menteeId: string;
 mentorId: string;
 dateTime: Date;
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
  validateReqBodyWithCake(CreateSessionRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    console.info("Posting new session,", req.query);
    try {
      const { menteeId, mentorId } = req.body;
      const meetingTime = new Date(req.body.dateInfo);
      const session = new Session({
        preSession: null,
        postSessionMentee: null,
        postSessionMentor: null,
        menteeId,
        mentorId,
        dateTime: meetingTime,
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
        message: `Session ${session.id} with mentee ${menteeId} and mentor ${mentorId} was successfully created.`,
      });
    } catch (e) {
      console.log(e);
      next(e);
      return res.status(400);
    }
  }
);

router.get("/sessions/:sessionId", [verifyAuthToken], async (req: Request, res: Response, next: NextFunction) => {
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
      dateTime,
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
        dateTime,
        preSessionCompleted,
        postSessionMenteeCompleted,
        postSessionMentorCompleted,
      },
    });
  } catch (e) {
    return next(e instanceof ServiceError ? e : InternalError.ERROR_GETTING_SESSION)
  }
});

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
      next();
      return res.status(400);
    }
  }
);

export { router as sessionsRouter };
