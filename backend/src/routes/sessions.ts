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
      const preNoteId = await createPreSessionNotes();
      const postMenteeNoteId = await createPostSessionNotes();
      const postMentorNoteId = await createPostSessionNotes();
      const { menteeId, mentorId } = req.body;
      const meetingTime = new Date(req.body.dateInfo);
      const session = new Session({
        preSession: preNoteId._id,
        postSessionMentee: postMenteeNoteId._id,
        postSessionMentor: postMentorNoteId._id,
        menteeId,
        mentorId,
        dateTime: meetingTime,
      });
      await session.save();
      return res.status(201).json({
        message: `Session ${session.id} with mentee ${menteeId} and mentor ${mentorId} was successfully created.`,
      });
    } catch (e) {
      next();
      return res.status(400);
    }
  }
);

router.get("/sessions/:sessionId", [verifyAuthToken], async (req: Request, res: Response) => {
  const sessionId = req.params.sessionId;
  if (!mongoose.Types.ObjectId.isValid(sessionId)) {
    return res
      .status(ServiceError.INVALID_MONGO_ID.status)
      .send(ServiceError.INVALID_MONGO_ID.message);
  }

  try {
    const session = await Session.findById(sessionId);
    if (!session) {
      throw ServiceError.SESSION_WAS_NOT_FOUND;
    }
    const { preSession, postSessionMentee, postSessionMentor, menteeId, mentorId, dateTime } = session;
    return res.status(200).send({
      message: `Here is session ${sessionId}`,
      session: {
        preSession,
        postSessionMentee,
        postSessionMentor,
        menteeId,
        mentorId,
        dateTime,
      },
    });
  } catch (e) {
    console.log(e);
    if (e instanceof ServiceError) {
      return res.status(e.status).send(e.displayMessage(true));
    }
    return res
      .status(InternalError.ERROR_GETTING_SESSION.status)
      .send(InternalError.ERROR_GETTING_SESSION.displayMessage(true));
  }
});

export { router as sessionsRouter };
