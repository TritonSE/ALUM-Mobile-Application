/**
 * This file contains routes that will be used for generic users
 * i.e. not separate for mentee and mentor.
 */
import express, { NextFunction, Request, Response } from "express";
// import { Infer } from "caketype";
import mongoose from "mongoose";
import { validateReqBodyWithCake } from "../middleware/validation";
import { Mentee, Mentor } from "../models";
import { getMenteeId, getMentorId, updateFCMToken } from "../services/user";
import { UpdateUserCake } from "../types";
import { InternalError } from "../errors/internal";
import { ServiceError } from "../errors/service";
import { verifyAuthToken } from "../middleware/auth";
import { CustomError } from "../errors";
import { getUpcomingSession, getLastSession } from "../services/session";

const router = express.Router();

// type UpdateUserType = Infer<typeof UpdateUserCake>
router.patch(
  "/user/:userId",
  [verifyAuthToken],
  validateReqBodyWithCake(UpdateUserCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      console.log("Updating FCM Token");
      const userId = req.params.userId;
      if (!mongoose.Types.ObjectId.isValid(userId)) {
        throw ServiceError.INVALID_MONGO_ID;
      }
      console.log("user id is valid");
      const role = req.body.role;
      const updatedToken = req.body.fcmToken;
      console.log("got information");
      await updateFCMToken(updatedToken, userId, role);
      res.status(200).json({
        message: "Success",
      });
    } catch (e) {
      next(e);
    }
  }
);

/**
 * Route to setup mobile app for any logged in user (mentor or mentee)
 *
 * This route returns the following
 * If user is a mentor,
 *  menteeIds, status, upcomingSessionId
 *
 * If user is mentee,
 *  mentorId, status, upcomingSessionId
 */
router.get(
  "/user/me",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.body.uid;
      const role = req.body.role;
      console.log(`GET /user/me uid - ${req.body.uid}`);

      const getUpcomingSessionPromise = getUpcomingSession(userId, role);
      const getPastSessionPromise = getLastSession(userId, role);
      if (role === "mentee") {
        // GET mentee document
        const mentee = await Mentee.findById(userId);
        if (!mentee) {
          throw ServiceError.MENTEE_WAS_NOT_FOUND;
        }

        if (mentee.status !== "paired") {
          res.status(200).send({
            status: mentee.status,
          });
          return;
        }
        const getPairedMentorIdPromise = getMentorId(mentee.pairingId);
        const [upcomingSessionId, pastSessionId, pairedMentorId] = await Promise.all([
          getUpcomingSessionPromise,
          getPastSessionPromise,
          getPairedMentorIdPromise,
        ]);
        res.status(200).send({
          status: mentee.status,
          sessionId: upcomingSessionId ?? pastSessionId,
          pairedMentorId,
        });
      } else if (role === "mentor") {
        const mentor = await Mentor.findById(userId);
        if (!mentor) {
          throw ServiceError.MENTOR_WAS_NOT_FOUND;
        }

        if (mentor.status !== "paired") {
          res.status(200).send({
            status: mentor.status,
          });
          return;
        }

        const getMenteeIdsPromises = mentor.pairingIds.map(async (pairingId) =>
          getMenteeId(pairingId)
        );

        // For MVP, we assume there is only 1 mentee 1 mentor pairing
        const getMenteeIdsPromise = getMenteeIdsPromises[0];

        const [upcomingSessionId, pastSessionId, pairedMenteeId] = await Promise.all([
          getUpcomingSessionPromise,
          getPastSessionPromise,
          getMenteeIdsPromise,
        ]);

        res.status(200).send({
          status: mentor.status,
          sessionId: upcomingSessionId ?? pastSessionId,
          pairedMenteeId,
        });
        return;
      }
    } catch (e) {
      if (e instanceof CustomError) {
        next(e);
        return;
      }
      next(InternalError.ERROR_GETTING_MENTEE);
    }
  }
);

export { router as selfRouter };
