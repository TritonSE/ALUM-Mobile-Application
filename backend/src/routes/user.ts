/**
 * This class contains routes that will create and get
 * new users
 */
import express, { NextFunction, Request, Response } from "express";
import { validateReqBodyWithCake } from "../middleware/validation";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { createUser } from "../services/auth";
import {
  CreateMenteeRequestBodyCake,
  CreateMentorRequestBodyCake,
  CreateMenteeRequestBodyType,
  CreateMentorRequestBodyType,
} from "../types";
import { ValidationError } from "../errors";

const router = express.Router();

/**
 * Validators used for routes
 */
const validateUserEmail = (email: string): boolean => {
  const EMAIL_REGEX = /^[A-Za-z0-9._%+-]+@(?!iusd.org)[A-Za-z0-9.-]+.[A-Za-z]{2,4}$/;
  return EMAIL_REGEX.test(email);
};

const validatePasswordLength = (password: string): boolean => {
  const REQUIRED_PASSWORD_LENGTH = 6;
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
      const imageId = "default";
      const about = "N/A";
      const mentee = new Mentee({
        name,
        imageId,
        about,
        status,
        ...args,
      });
      await createUser(mentee._id.toString(), email, password);
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
      const { name, email, password, personalAccessToken, ...args }: CreateMentorRequestBodyType =
        req.body;

      if (!validateUserEmail(email)) {
        throw ValidationError.INVALID_EMAIL_ID;
      }

      if (!validatePasswordLength(password)) {
        throw ValidationError.INVALID_PASSWORD_LENGTH;
      }

      const status = "under review";
      const imageId = "default";
      const about = "N/A";
      const calendlyLink = "N/A";
      const mentor = new Mentor({
        name,
        imageId,
        about,
        calendlyLink,
        status,
        personalAccessToken,
        ...args,
      });
      await createUser(mentor._id.toString(), email, password);
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

export { router as userRouter };
