/**
 * This file contains the route that will create a session
 */

import express, { NextFunction, Request, Response } from "express";
import mongoose from "mongoose";
import { Session } from "../models/session";
import { createPreSessionNotes, createPostSessionNotes } from "../services/note";
import { verifyAuthToken } from "../middleware/auth";
import { InternalError } from "../errors/internal";
import { verifyAuthToken } from "../middleware/auth";
import { ServiceError } from "../errors/service";
import { InternalError } from "../errors/internal";
import { validateReqBodyWithCake } from "../middleware/validation";
import { CreateSessionRequestBodyCake } from "../types/cakes";

import {database} from "../app";
import { verifyAuthToken } from "../middleware/auth";
import { InternalError } from "../errors/internal";
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
      return res.status(400).json({
        error: e
      });
    }
  }
);

router.get("/sessions/:sessionId", [verifyAuthToken], async (req: Request, res: Response) => {
  const sessionId = req.params.sessionId;
  try {
  if (!mongoose.Types.ObjectId.isValid(sessionId)) {
   throw ServiceError.INVALID_MONGO_ID;
  }
    const session = await Session.findById(sessionId);
    if (!session) {
      throw ServiceError.SESSION_WAS_NOT_FOUND;
    }
    const { preSession, postSessionMentee, postSessionMentor, menteeId, mentorId, dateTime } =
      session;
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
    throw InternalError.ERROR_GETTING_SESSION;
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
    const { preSession, postSession, menteeId, mentorId, dateTime } = session;
    return res.status(200).send({
      message: `Here is session ${sessionId}`,
      session: {
        preSession,
        postSession,
        menteeId,
        mentorId,
        dateTime,
      },
    });

router.get(
  "/sessions",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    const userID = req.body.uid;
    const role = req.body.role;
    let userSessions;
    if (role === null || userID === null) {
      throw InternalError.ERROR_GETTING_SESSION
    }
    try {
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
