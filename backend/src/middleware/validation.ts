/**
 * This file is used to store functions the validate requests
 * for the various routes. The type checking is done using
 * Justin's caketype library (see github for specifications).
 * https://github.com/justinyaodu/caketype
 * All error messages are stored in the errors.ts file.
 *
 *
 * All requests must have a function to validate the requests.
 * Moreover, be sure to add cake types of each type of request you
 * are validating (look below for examples).
 */

import { bake, string, array } from "caketype";
import { Request, Response, NextFunction } from "express";
import { ValidationError } from "../errors/validationError";

/**
 * mentee cake type to be used to validate mentee
 * NOTE: proper request will follow this format
 */
const MENTEE = bake({
  name: string,
  email: string,
  password: string,
  grade: string,
  topicsOfInterest: array(string),
  careerInterests: array(string),
  mentorshipGoal: string,
});

/**
 * mentor cake type to be used to validate mentor
 * NOTE: proper request will follow this format
 */
const MENTOR = bake({
  name: string,
  email: string,
  password: string,
  graduationYear: string,
  college: string,
  major: string,
  minor: string,
  career: string,
  topicsOfExpertise: array(string),
  mentorMotivation: string,
  organizationId: string,
  personalAccessToken: string,
});

/**
 * Function to validate whether proper inputs were given
 * in the request when generating mentee.
 * @param req: request
 * @param res: response
 * @param next: next function to be called
 * @returns
 */
const validateMentee = (req: Request, res: Response, next: NextFunction) => {
  const requestBody = req.body;

  const menteeCheck = MENTEE.check(requestBody);

  if (!menteeCheck.ok) {
    return res.status(400).send(menteeCheck.error.toString());
  }
  const emailValidation = /^[A-Za-z0-9._%+-]+@(?!iusd.org)[A-Za-z0-9.-]+.[A-Za-z]{2,4}$/;

  if (!emailValidation.test(requestBody.email)) {
    return res
      .status(ValidationError.INVALID_EMAIL_ID.status)
      .send(ValidationError.INVALID_EMAIL_ID.displayMessage(true));
  }

  if (requestBody.password.length < 6) {
    return res
      .status(ValidationError.INVALID_PASSWORD_LENGTH.status)
      .send(ValidationError.INVALID_PASSWORD_LENGTH.displayMessage(true));
  }

  return next();
};

/**
 * Function to validate whether proper inputs were given
 * in the request when generating mentor.
 * @param req: request
 * @param res: response
 * @param next: next function to be called
 * @returns
 */
const validateMentor = (req: Request, res: Response, next: NextFunction) => {
  const requestBody = req.body;

  const mentorCheck = MENTOR.check(requestBody);
  if (!mentorCheck.ok) {
    return res.status(400).send(mentorCheck.error.toString());
  }

  const emailValidation = /^[A-Za-z0-9._%+-]+@(?!iusd.org)[A-Za-z0-9.-]+.[A-Za-z]{2,4}$/;

  if (!emailValidation.test(requestBody.email)) {
    return res
      .status(ValidationError.INVALID_EMAIL_ID.status)
      .send(ValidationError.INVALID_EMAIL_ID.displayMessage(true));
  }

  if (requestBody.password.length < 6) {
    return res
      .status(ValidationError.INVALID_PASSWORD_LENGTH.status)
      .send(ValidationError.INVALID_PASSWORD_LENGTH.displayMessage(true));
  }

  return next();
};

export { validateMentee, validateMentor };
