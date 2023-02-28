/**
 * This file contains routes that will create and get
 * sessions
 */

import express, { NextFunction, Request, Response } from "express";
import { Session } from "../models/session";
import { createPreSessionNotes, createPostSessionNotes } from "../services/note"; 
const router=express.Router();

router.post( 
    "/sessions",
    async (req: Request, res: Response, next: NextFunction) => {
      console.info("Posting new session,", req.query);
      let notes=null
      try{
        const preNoteId= await createPreSessionNotes()
        const postNoteId= await createPostSessionNotes()
        const {menteeId, mentorId} = req.body;
        const meetingTime = new Date(req.body.dateInfo)
        const session = new Session({preSession : preNoteId._id.toString(), postSession : postNoteId._id.toString(), menteeId, mentorId, dateTime : meetingTime});
        await session.save();
        return res.status(201).json({
          message: `Session with mentee ${menteeId} and mentor ${mentorId} was successfully created.`,
        });
      }
      catch(e){

        console.log(e);
        // next();
        // return res.status(400).json({
        //   message: e.message
        // });
      }
    }
  );

export {router as sessionsRouter}