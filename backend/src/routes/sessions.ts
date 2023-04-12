/**
 * This file contains routes that will create and get
 * sessions
 */

import { DBRef } from "bson";
import express, { NextFunction, Request, Response } from "express";
import { Session } from "../models/session";
import { createPreSessionNotes, createPostSessionNotes } from "../services/note";
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
router.post("/sessions", async (req: Request, res: Response, next: NextFunction) => {
  console.info("Posting new session,", req.query);
  try {
    const preNoteId = await createPreSessionNotes();
    const postNoteId = await createPostSessionNotes();
    const { menteeId, mentorId } = req.body;
    const meetingTime = new Date(req.body.dateInfo);
    const session = new Session({
      preSession: preNoteId._id,
      postSession: postNoteId._id,
      menteeId,
      mentorId,
      dateTime: meetingTime,
    });
    await session.save();
    return res.status(201).json({
      message: `Session with mentee ${menteeId} and mentor ${mentorId} was successfully created.`,
    });
  } catch (e) {
    next();
    return res.status(400);
  }
});


router.get("/sessions", [verifyAuthToken], async (req: Request, res: Response, next: NextFunction) =>{
  const userID = req.body.uid;
  let role = req.body.role;
  let userSessions;
  if(role === null || userID === null){
    return res.status(InternalError.ERROR_GETTTING_SESSION.status)
    .send(InternalError.ERROR_GETTTING_SESSION.message);
  }
  try{
  if(role==="mentee"){
      userSessions = await Session.find({menteeId: {$eq : userID}});
  }
  if (role === "mentor"){
      userSessions = await Session.find({mentorId: {$eq: userID}});
  }
  if(userSessions===null){
      return res.status(400).json({
        message: `No sessions found for user ${userID}!`
      })
    }
  return res.status(200).json({
      message: `Sessions for user ${userID}:`,
      sessions: userSessions
    })
  }
  catch(e){
    next();
    return res.status(400);
  }
});

export { router as sessionsRouter };
