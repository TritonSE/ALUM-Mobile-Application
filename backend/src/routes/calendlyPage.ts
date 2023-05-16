import express, { NextFunction, Request, Response } from "express";
import { Mentor, Mentee } from "../models";
import { verifyAuthToken } from "../middleware/auth";
import { ServiceError } from "../errors";
import { getMentorId } from "../services/user";

const router = express.Router();

router.get(
  "/calendly",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userUid = req.body.uid;
      const mentee = await Mentee.findById(userUid);
      if (!mentee) {
        throw ServiceError.MENTEE_WAS_NOT_FOUND;
      }
      const mentorId = await getMentorId(mentee.pairingId);
      const mentor = await Mentor.findById(mentorId);
      if (!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }
      const calendlyLink = mentor.calendlyLink;
      res.render("index", { calendlyLink });
    } catch (e) {
      next(e);
    }
  }
);

export { router as calendlyPage };
