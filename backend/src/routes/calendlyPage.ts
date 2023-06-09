import express, { NextFunction, Request, Response } from "express";
import { Mentor, Mentee } from "../models";
import { verifyAuthToken } from "../middleware/auth";
import { ServiceError } from "../errors";
import { getMentorId } from "../services/user";

const router = express.Router();

/**
 * This is the route for the html page used to embed
 * a Mentor's calendly page
 */
router.get(
  "/calendly",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userUid = req.body.uid;
      const userRole = req.body.role;

      let mentorId = null;
      if (userRole === "mentee") {
        const mentee = await Mentee.findById(userUid);
        if (!mentee) {
          throw ServiceError.MENTEE_WAS_NOT_FOUND;
        }
        mentorId = await getMentorId(mentee.pairingId);
      } else if (userRole === "mentor") {
        mentorId = userUid;
      }

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
