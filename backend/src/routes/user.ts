/**
 * This file contains routes that will create and get
 * new users
 */
import express, { NextFunction, Request, Response } from "express";
// import { Infer } from "caketype";
import mongoose from "mongoose";
import { validateReqBodyWithCake } from "../middleware/validation";
import { Mentee, Mentor, Pairing } from "../models";
import { createUser } from "../services/auth";
import {
  getMenteeId,
  getMentorId,
  updateMentor,
  updateMentee,
  updateMentorFCMToken,
  updateMenteeFCMToken,
} from "../services/user";
import {
  CreateMenteeRequestBodyCake,
  CreateMentorRequestBodyCake,
  CreateMenteeRequestBodyType,
  CreateMentorRequestBodyType,
  UpdateUserCake,
  UpdateMentorRequestBodyCake,
  UpdateMenteeRequestBodyCake,
  UpdateMentorRequestBodyType,
  UpdateMenteeRequestBodyType,
} from "../types";
import { ValidationError } from "../errors/validationError";
import { InternalError } from "../errors/internal";
import { ServiceError } from "../errors/service";
import { verifyAuthToken } from "../middleware/auth";
import { defaultImageID } from "../config";
import { CustomError } from "../errors";
import { AuthError } from "../errors/auth";
import { getUpcomingSession, getLastSession } from "../services/session";
import { validateCalendlyAccessToken, validateCalendlyLink } from "../services/calendly";

const router = express.Router();

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
      const fcmToken = "N/A";
      const mentee = new Mentee({
        name,
        imageId,
        about,
        status,
        pairingId,
        fcmToken,
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
      const {
        name,
        email,
        password,
        personalAccessToken,
        calendlyLink,
        ...args
      }: CreateMentorRequestBodyType = req.body;

      if (!validateUserEmail(email)) {
        throw ValidationError.INVALID_EMAIL_ID;
      }

      if (!validatePasswordLength(password)) {
        throw ValidationError.INVALID_PASSWORD_LENGTH;
      }

      await validateCalendlyAccessToken(personalAccessToken);
      await validateCalendlyLink(calendlyLink);

      const status = "under review";
      const imageId = defaultImageID;
      const about = "N/A";
      const zoomLink = "N/A";
      const pairingIds: string[] = [];
      const fcmToken = "N/A";
      const mentor = new Mentor({
        name,
        imageId,
        about,
        zoomLink,
        status,
        pairingIds,
        fcmToken,
        personalAccessToken,
        calendlyLink,
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

      if (status !== "paired") {
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
          },
        });
        return;
      }

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
      console.log(`GET /mentor/${userId} uid - ${req.body.uid}`);

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
        location,
        topicsOfExpertise,
        pairingIds,
        mentorMotivation,
        status,
      } = mentor;

      if (status !== "paired") {
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
            zoomLink: location,
            topicsOfExpertise,
          },
        });
        return;
      }

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
            zoomLink: location,
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
        console.log({
          mentorId,
          name,
          imageId,
          about,
          calendlyLink,
          zoomLink: location,
          graduationYear,
          college,
          major,
          minor,
          career,
          topicsOfExpertise,
          mentorMotivation,
          menteeIds,
          status,
        });

        res.status(200).send({
          message: `Here is mentor ${mentor.name}`,
          mentor: {
            mentorId,
            name,
            imageId,
            about,
            calendlyLink,
            zoomLink: location ?? "N/A",
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

// type UpdateUserType = Infer<typeof UpdateUserCake>
router.patch(
  "/user/:userId",
  [verifyAuthToken],
  validateReqBodyWithCake(UpdateUserCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      console.log("Starting patch");
      const userId = req.params.userId;
      if (!mongoose.Types.ObjectId.isValid(userId)) {
        throw ServiceError.INVALID_MONGO_ID;
      }
      console.log("user id is valid");
      const role = req.body.role;
      const updatedToken = req.body.fcmToken;
      console.log("got information");
      if (role === "mentee") {
        await updateMenteeFCMToken(updatedToken, userId);
      } else if (role === "mentor") {
        await updateMentorFCMToken(updatedToken, userId);
      }
      res.status(200).json({
        message: "Success",
      });
    } catch (e) {
      console.log("error");
      next(e);
    }
  }
);

/**
 * * This route will update a mentor's values.
 * @param userId: userId of mentor to be updated
 * @body The body should be a JSON in the form:
 * {
    "name": string,
    "personalAccessToken": string,
    "about": string,
    "graduationYear": number,
    "college": string,
    "major": string,
    "imageId": string,
    "minor": string,
    "career": string,
    "topicsOfExpertise": string[],
    "mentorMotivation": string,
    "location": string,
    "calendlyLink": string,
    "zoomLink": string
 * }
 * @response "Success" with new, updated mentor if successfully updated, "Invalid" otherwise.
 */
router.patch(
  "/mentor/:userId",
  validateReqBodyWithCake(UpdateMentorRequestBodyCake),
  [verifyAuthToken],
  // validateReqBodyWithCake(UpdateMentorRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userID = req.params.userId;
      console.log(`PATCH /mentor/${userID} uid - ${req.body.uid}`);

      if (!mongoose.Types.ObjectId.isValid(userID)) {
        throw ServiceError.INVALID_MONGO_ID;
      }

      const role = req.body.role;
      if (role === "mentee") {
        throw AuthError.INVALID_AUTH_TOKEN;
      }
      console.log("Update /mentor", req.body);

      const updatedMentor: UpdateMentorRequestBodyType = req.body;
      await updateMentor(updatedMentor, userID);
      const mentor = await Mentor.findById(userID);
      res.status(200).json({
        message: "Success",
        updatedMentor: mentor,
      });
    } catch (e) {
      next(e);
    }
  }
);

/**
 * * This route will update a mentee's values.
 * @param userId: userId of mentee to be updated
 * @body The body should be a JSON in the form:
 * {
    "name": string,
    "grade": number,
    "about": string,
    "imageId": string,
    "topicsOfInterest": string[],
    "careerInterests": string[],
    "mentorshipGoal": string,
}
  * @response "Success" with new, updated mentee if successfully updated, "Invalid" otherwise.
  */
router.patch(
  "/mentee/:userId",
  validateReqBodyWithCake(UpdateMenteeRequestBodyCake),
  [verifyAuthToken],
  // validateReqBodyWithCake(UpdateMenteeRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userID = req.params.userId;
      console.log(`PATCH /mentee/${userID} uid - ${req.body.uid}`);

      if (!mongoose.Types.ObjectId.isValid(userID)) {
        throw ServiceError.INVALID_MONGO_ID;
      }

      const role = req.body.role;
      if (role === "mentor") {
        throw AuthError.INVALID_AUTH_TOKEN;
      }
      console.log("Update /mentee", req.body);
      const updatedMentee: UpdateMenteeRequestBodyType = req.body;
      await updateMentee(updatedMentee, userID);
      const mentee = await Mentee.findById(userID);
      res.status(200).json({
        message: "Success",
        updatedMentee: mentee,
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

export { router as userRouter };
