/**
 * This file contains routes that will create and get
 * new users
 */
import express, { NextFunction, Request, Response } from "express";
import mongoose from "mongoose";
import { validateReqBodyWithCake } from "../middleware/validation";
// import multer from "multer";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { Pairing } from "../models/pairing";
import { createUser } from "../services/auth";
import {
  CreateMenteeRequestBodyCake,
  CreateMentorRequestBodyCake,
  CreateMenteeRequestBodyType,
  CreateMentorRequestBodyType,
} from "../types";
import { ValidationError } from "../errors/validationError";
import { InternalError } from "../errors/internal";
import { ServiceError } from "../errors/service";
import { verifyAuthToken } from "../middleware/auth";
import { defaultImageID } from "../config";
import { CustomError } from "../errors";

const router = express.Router();

// const upload = multer({ storage: multer.memoryStorage() }).single("image");

/**
 * Validators used for routes
 */
const validateUserEmail = (email: string): boolean => {
  const EMAIL_REGEX = /^[A-Za-z0-9._%+-]+@(?!iusd.org)[A-Za-z0-9.-]+.[A-Za-z]{2,4}$/;
  return EMAIL_REGEX.test(email);
};

const validatePasswordLength = (password: string): boolean => {
  const REQUIRED_PASSWORD_LENGTH = 8;
  return password.length >= REQUIRED_PASSWORD_LENGTH;
};

/**
 * This is a post route to create a new mentee.
 * Given the following checks pass, a new mentee is created
 *
 * Request Body is validated to match CreateMenteeRequestBodyCake.
 * Checks are also added to enforce the following -
 *     - Email does not end with @iusd.org
 *     - Password is greater than REQUIRED_PASSWORD_LENGTH
 *
 * @returns String
 * Validation Error messages from type check or the other checks OR success message
 */
router.post(
  "/mentee",
  validateReqBodyWithCake(CreateMenteeRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      console.log("POST /mentee", req.query);
      const { name, email, password, ...args }: CreateMenteeRequestBodyType = req.body;

      if (!validateUserEmail(email)) {
        throw ValidationError.INVALID_EMAIL_ID;
      }

      if (!validatePasswordLength(password)) {
        throw ValidationError.INVALID_PASSWORD_LENGTH;
      }

      const status = "under review";
      const imageId = defaultImageID;
      const about = "N/A";
      const pairingId = "N/A";
      const mentee = new Mentee({
        name,
        imageId,
        about,
        status,
        pairingId,
        ...args,
      });
      await mentee.save();
      await createUser(mentee._id.toString(), email, password, "mentee");
      res.status(201).json({
        message: `Mentee ${name} was succesfully created.`,
        userID: mentee._id,
      });
    } catch (err) {
      next(err);
    }
  }
);

/**
 * This is a post route to create a new mentee.
 * Given the following checks pass, a new mentor is created
 *
 * Request Body is validated to match CreateMentorRequestBodyCake.
 * Checks are also added to enforce the following -
 *     - Email does not end with @iusd.org
 *     - Password is greater than REQUIRED_PASSWORD_LENGTH
 *
 * @returns String
 * Validation Error messages from type check or the other checks OR success message
 */
router.post(
  "/mentor",
  validateReqBodyWithCake(CreateMentorRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      console.info("POST /mentor", req.body);
      const { name, email, password, ...args }: CreateMentorRequestBodyType = req.body;

      if (!validateUserEmail(email)) {
        throw ValidationError.INVALID_EMAIL_ID;
      }

      if (!validatePasswordLength(password)) {
        throw ValidationError.INVALID_PASSWORD_LENGTH;
      }

      const status = "under review";
      const imageId = defaultImageID;
      const about = "N/A";
      const pairingIds: string[] = [];
      const mentor = new Mentor({
        name,
        imageId,
        about,
        status,
        pairingIds,
        ...args,
      });
      await mentor.save();
      await createUser(mentor._id.toString(), email, password, "mentor");     
      res.status(201).json({
        message: `Mentor ${name} was successfully created.`,
        userID: mentor._id,
      });
    } catch (err) {
      next(err);
    }
  }
);

/**
 * This is a get route for a mentee. Note that the response is dependant on
 * the person calling the method
 *
 * Mentee calling: gain all info about the mentee
 *
 * Mentor calling: mentee name, image, grade, about, career interests, topics of interest
 */
router.get(
  "/mentee/:userId",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.params.userId;
      if (!mongoose.Types.ObjectId.isValid(userId)) {
        throw ServiceError.INVALID_MONGO_ID;
      }
      const role = req.body.role;
      const mentee = await Mentee.findById(userId);
      if (!mentee) {
        throw ServiceError.MENTEE_WAS_NOT_FOUND;
      }
      const {
        _id: menteeId,
        name,
        imageId,
        about,
        grade,
        topicsOfInterest,
        careerInterests,
        mentorshipGoal,
        pairingId,
        status,
      } = mentee;
      const pairing = await Pairing.findById(pairingId);
      if (role === "mentee") {
        let mentorId = "N/A";
        if (pairing) {
          mentorId = pairing.mentorId;
        }
        res.status(200).send({
          message: `Here is mentee ${mentee.name}`,
          mentee: {
            menteeId,
            name,
            imageId,
            about,
            grade,
            topicsOfInterest,
            careerInterests,
            mentorshipGoal,
            mentorId,
            status,
          },
        });
        return;
      }
      if (role === "mentor") {
        let whyPaired = "N/A";
        if (pairing) {
          whyPaired = pairing.whyPaired;
        }
        res.status(200).send({
          message: `Here is mentee ${mentee.name}`,
          mentee: {
            menteeId,
            name,
            imageId,
            about,
            grade,
            topicsOfInterest,
            careerInterests,
            whyPaired,
          },
        });
        return;
      }
      throw InternalError.ERROR_ROLES_NOT_MENTOR_MENTEE_NOT_IMPLEMENTED;
    } catch (e) {
      if (e instanceof CustomError) {
        next(e);
        return;
      }
      next(InternalError.ERROR_GETTING_MENTEE);
    }
  }
);

/**
 * This is a get route for a mentor. Note that the response is dependant on the person
 * calling the method
 *
 * Mentee calling: mentor name, image, major, minor, college, career, graduation year, calendlyLink,
 * why were you paired?, about, topics of experties
 *
 * Mentor calling: gain all info about the mentor
 */
router.get(
  "/mentor/:userId",
  [verifyAuthToken],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.params.userId;
      if (!mongoose.Types.ObjectId.isValid(userId)) {
        throw ServiceError.INVALID_MONGO_ID;
      }

      const role = req.body.role;
      const clientId = req.body.uid;

      const mentor = await Mentor.findById(userId);
      if (!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }

      const {
        _id: mentorId,
        name,
        imageId,
        about,
        major,
        minor,
        college,
        career,
        graduationYear,
        calendlyLink,
        topicsOfExpertise,
        pairingIds,
        mentorMotivation,
        status,
      } = mentor;

      if (role === "mentee") {
        const promises = pairingIds.map(async (pairingId): Promise<string | null> => {
          const pairing = await Pairing.findById(pairingId);
          if (pairing && pairing.menteeId === clientId) {
            return pairing.whyPaired;
          }
          return null;
        });
        const results = await Promise.all(promises);
        const whyPaired = results.find((result) => result !== undefined && result !== null);

        res.status(200).send({
          message: `Here is mentor ${mentor.name}`,
          mentor: {
            mentorId,
            name,
            about,
            imageId,
            major,
            minor,
            college,
            career,
            graduationYear,
            calendlyLink,
            topicsOfExpertise,
            whyPaired,
          },
        });
        return;
      }
      if (role === "mentor") {
        const promises = pairingIds.map(async (pairingId) => {
          const pairing = await Pairing.findById(pairingId);
          return pairing?.menteeId;
        });
        const menteeIds = await Promise.all(promises);
        res.status(200).send({
          message: `Here is mentor ${mentor.name}`,
          mentor: {
            mentorId,
            name,
            imageId,
            about,
            calendlyLink,
            graduationYear,
            college,
            major,
            minor,
            career,
            topicsOfExpertise,
            mentorMotivation,
            menteeIds,
            status,
          },
        });
        return;
      }
      throw InternalError.ERROR_ROLES_NOT_MENTOR_MENTEE_NOT_IMPLEMENTED;
    } catch (e) {
      if (e instanceof ServiceError) {
        next(e);
        return;
      }
      next(InternalError.ERROR_GETTING_MENTOR);
    }
  }
);

export { router as userRouter };
