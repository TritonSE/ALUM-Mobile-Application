/**
 * This file contains routes that will create and get
 * sessions
 */

import express, { NextFunction, Request, Response } from "express";
import {  } from "../models/question";
import { Session } from "../models/session";

const router=express.Router();

router.post( 
    "/sessions",
    async (req: Request, res: Response, next: NextFunction) => {
      console.info("Posting new session,", req.query);
      try{
        const {menteeId, mentorId} = req.body;
        const session = new Session({menteeId, mentorId});
        await session.save();
        return res.status(201).json({
          message: `Session with mentee ${menteeId} and mentor ${mentorId} was successfully created.`,
        });
      }
      catch(e){
        next();
        return res.status(400);
      }
    }
  );

export {router as sessionsRouter}