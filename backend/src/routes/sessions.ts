/**
 * This file contains the route that will create a session
 */

import express, { NextFunction, Request, Response } from "express";
import { Session } from "../models/session";
import { createPreSessionNotes, createPostSessionNotes } from "../services/note";
import { validateReqBodyWithCake } from "../middleware/validation";
import { CreateSessionRequestBodyCake } from "../types/cakes";
import { getCalendlyEventDate } from "../services/calendly";
import { ServiceError } from "../errors";
import { Mentor } from "../models/mentor";
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
  validateReqBodyWithCake(CreateSessionRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    console.info("Posting new session,", req.query);
    try {
      const preNoteId = await createPreSessionNotes();
      const postNoteId = await createPostSessionNotes();
      const { menteeId, mentorId } = req.body;
      const mentor = await Mentor.findById(mentorId);
      if(!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }
      const accessToken = mentor.personalAccessToken;
      const meetingTime = await getCalendlyEventDate(req.body.calendlyURI, accessToken);
      const session = new Session({
        preSession: preNoteId._id,
        postSession: postNoteId._id,
        menteeId,
        mentorId,
        dateTime: meetingTime,
      });
      await session.save();
      return res.status(201).json({
        message: `Session ${session.id} with mentee ${menteeId} and mentor ${mentorId} was successfully created.`,
      });
    } catch (e) {
      console.log(e)
      next();
      return res.status(400);
    }
  }
);

export { router as sessionsRouter };
