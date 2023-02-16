/**
 * This file contains routes that will create and get
 * sessions
 */

import express, { NextFunction, Request, Response } from "express";
import { createTextQuestion, createBulletQuestion, Question } from "../models/question";
import { Session } from "../models/session";

const router=express.Router();

router.post(
    "/sessions",
    async (req: Request, res: Response, next: NextFunction) => {
      console.info("Posting new session,", req.query);
      try{
        let txtQ1=createTextQuestion("What do you want?");
        let bulletQ1= createBulletQuestion("What are your favorite subjects?")
        var pre:Question[]=[txtQ1];
        var post:Question[]=[bulletQ1];
        const {menteeId, mentorId} = req.body;
        const session = new Session({pre, post, menteeId, mentorId});
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