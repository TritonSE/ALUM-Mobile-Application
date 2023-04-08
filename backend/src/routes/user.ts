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
      await createUser(mentee._id.toString(), email, password, "mentee");
      await mentee.save();
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
      const calendlyLink = "N/A";
      const pairingIds: string[] = [];
      const mentor = new Mentor({
        name,
        imageId,
        about,
        calendlyLink,
        status,
        pairingIds,
        ...args,
      });
      await createUser(mentor._id.toString(), email, password, "mentor");
      await mentor.save();
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
router.get("/mentee/:userId", [verifyAuthToken], async (req: Request, res: Response) => {
  const userId = req.params.userId;
  if (!mongoose.Types.ObjectId.isValid(userId)) {
    return res
      .status(ServiceError.INVALID_MONGO_ID.status)
      .send(ServiceError.INVALID_MONGO_ID.message);
  }
  const role = req.body.role;

  if (role === "mentee") {
    try {
      const mentee = await Mentee.findById(userId);
      if (!mentee) {
        throw ServiceError.MENTEE_WAS_NOT_FOUND;
      }
      const {
        _id,
        name,
        imageId,
        about,
        grade,
        topicsOfInterest,
        careerInterests,
        mentorshipGoal,
        pairingId,
        status
      } = mentee;
      let mentorId = "N/A"
      const pairing = await Pairing.findById(pairingId);
      if(pairing) {
        mentorId = pairing.mentorId;
      }
      return res.status(200).send({
        message: `Here is mentee ${mentee.name}`,
        _id,
        name,
        imageId,
        about,
        grade,
        topicsOfInterest,
        careerInterests,
        mentorshipGoal,
        mentorId,
        status
      });
    } catch (e) {
      console.log(e);
      if (e instanceof ServiceError) {
        return res.status(e.status).send(e.displayMessage(true));
      }
      return res
        .status(InternalError.ERROR_GETTING_MENTEE.status)
        .send(InternalError.ERROR_GETTING_MENTEE.displayMessage(true));
    }
  }

  if (role === "mentor") {
    try {
      const mentee = await Mentee.findById(userId);
      if (!mentee) {
        throw ServiceError.MENTEE_WAS_NOT_FOUND;
      }
      const { name, imageId, about, grade, topicsOfInterest, careerInterests, pairingId } = mentee;
      let whyPaired = "N/A"
      const pairing = await Pairing.findById(pairingId);
      if(pairing) {
        whyPaired = pairing.whyPaired;
      } 
      return res.status(200).send({
        message: `Here is mentee ${mentee.name}`,
        mentee: {
          name,
          imageId,
          about,
          grade,
          topicsOfInterest,
          careerInterests,
          whyPaired,
        },
      });
    } catch (e) {
      console.log(e);
      if (e instanceof ServiceError) {
        return res.status(e.status).send(e.displayMessage(true));
      }
      return res
        .status(InternalError.ERROR_GETTING_MENTEE.status)
        .send(InternalError.ERROR_GETTING_MENTEE.displayMessage(true));
    }
  }

  return res.status(405).send("Mentee or Mentor not accessing data");
});

/**
 * This is a get route for a mentor. Note that the response is dependant on the person
 * calling the method
 *
 * Mentee calling: mentor name, image, major, minor, college, career, graduation year, calendlyLink,
 * why were you paired?, about, topics of experties
 *
 * Mentor calling: gain all info about the mentor
 */
router.get("/mentor/:userId", [verifyAuthToken], async (req: Request, res: Response) => {
  const userId = req.params.userId;
  if (!mongoose.Types.ObjectId.isValid(userId)) {
    return res
      .status(ServiceError.INVALID_MONGO_ID.status)
      .send(ServiceError.INVALID_MONGO_ID.message);
  }
  const role = req.body.role;

  if (role === "mentee") {
    try {
      const mentor = await Mentor.findById(userId);
      if (!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }
      const {
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
      } = mentor;
      let whyPaired = "N/A";
      for(const i in pairingIds) {
        const pairing = await Pairing.findById(pairingIds[i]);
        if(pairing?.menteeId === userId) {
          whyPaired = pairing.whyPaired;
        }
      }
      return res.status(200).send({
        message: `Here is mentor ${mentor.name}`,
        mentor: {
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
    } catch (e) {
      console.log(e);
      if (e instanceof ServiceError) {
        return res.status(e.status).send(e.displayMessage(true));
      }
      return res
        .status(InternalError.ERROR_GETTING_MENTOR.status)
        .send(InternalError.ERROR_GETTING_MENTOR.displayMessage(true));
    }
  }

  if (role === "mentor") {
    try {
      const mentor = await Mentor.findById(userId);
      if (!mentor) {
        throw ServiceError.MENTOR_WAS_NOT_FOUND;
      }
      const {
        _id,
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
        pairingIds,
        status
      } = mentor;
      let menteeIds = [];
      for(const i in pairingIds) {
        const pairing = await Pairing.findById(pairingIds[i]);
        menteeIds.push(pairing?.menteeId);
      }
      return res.status(200).send({
        message: `Here is mentor ${mentor.name}`,
        _id,
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
        status
      });
    } catch (e) {
      console.log(e);
      if (e instanceof ServiceError) {
        return res.status(e.status).send(e.displayMessage(true));
      }
      return res
        .status(InternalError.ERROR_GETTING_MENTOR.status)
        .send(InternalError.ERROR_GETTING_MENTOR.displayMessage(true));
    }
  }

  return res.status(405).send("Mentee or Mentor not accessing data");
});

export { router as userRouter };
