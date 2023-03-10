/**
 * This class contains routes that will create and get
 * new users
 */
import express, { Request, Response } from "express";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { validateMentee, validateMentor } from "../middleware/validation";
import { createUser } from "../services/auth";
import { ValidationError } from "../errors/validationError";
import { saveImage }  from "../services/user";
import multer from "multer";
import fs from 'fs';
import path from 'path';

const router = express.Router();

const upload = multer({ storage: multer.memoryStorage()}).single('image');


/**
 * This is a post route to create a new mentee. It will first validate
 * the mentee to ensure they follow standard listed below before adding them to
 * mongoDB and Firebase
 *
 * Mentee: {name: string, email: string, password: string, grade: string,
 * topicsOfInterest: string[], careerInterests: string[], mentorshipGoal: string}
 */
router.post("/mentee", [validateMentee], async (req: Request, res: Response) => {
  try {
    console.info("Creating new mentee", req.query);
    const { name, email, password, grade, topicsOfInterest, careerInterests, mentorshipGoal } =
      req.body;
    const status = "under review";
    const imageId = "default";
    const about = "N/A";
    const mentee = new Mentee({
      name,
      imageId,
      about,
      grade,
      topicsOfInterest,
      careerInterests,
      mentorshipGoal,
      status,
    });
    await createUser(mentee._id.toString(), email, password);
    await mentee.save();
    return res.status(201).json({
      message: `Mentee ${name} was succesfully created.`,
      userID: mentee._id,
    });
  } catch (err) {
    if (err instanceof ValidationError) {
      return res.status(err.status).send(err.displayMessage(true));
    }
    return res.status(500).send("Unknown Error. Try again");
  }
});

/**
 * This is a post route to create a new mentor. It will first validate
 * the mentor to ensure they follow standard listed below before adding them to
 * mongoDB and Firebase
 *
 * Mentor: {name: string, email: string, password: string, graduationYear; string
 * college: string, major: string, minor: string, career: string,
 * topicsOfExpertise: string[], mentorMotivation: string, organizationId: string,
 * personalAccessToken: string}
 */
router.post("/mentor", [validateMentor], async (req: Request, res: Response) => {
  try {
    console.info("Creating new mentor", req.query);
    const {
      name,
      email,
      password,
      graduationYear,
      college,
      major,
      minor,
      career,
      topicsOfExpertise,
      mentorMotivation,
      organizationId,
      personalAccessToken,
    } = req.body;
    const status = "under review";
    const imageId = "default";
    const about = "N/A";
    const calendlyLink = "N/A";
    const mentor = new Mentor({
      name,
      imageId,
      about,
      calendlyLink,
      organizationId,
      graduationYear,
      college,
      major,
      minor,
      career,
      topicsOfExpertise,
      mentorMotivation,
      personalAccessToken,
      status,
    });
    await createUser(mentor._id.toString(), email, password);
    await mentor.save();
    return res.status(201).json({
      message: `Mentor ${name} was successfully created.`,
      userID: mentor._id,
    });
  } catch (err) {
    if (err instanceof ValidationError) {
      return res.status(err.status).send(err.displayMessage(true));
    }
    return res.status(500).send("Unknown Error. Try again");
  }
});

/**
 * This is a get route for a mentee. Note that the response is dependant on 
 * the person calling the method
 * 
 * Mentee calling: gain all info about the mentee
 * 
 * Mentor calling: mentee name, image, grade, about, career interests, topics of interest
 */
router.get("/mentee", [upload], async (req: Request, res: Response) => {
  if(req.file) {
    const image_id = await saveImage(req);
    console.log(image_id);
    return res.status(201).send(image_id);
  }

});

export { router as userRouter };
