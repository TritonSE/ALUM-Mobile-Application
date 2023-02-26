/**
 * This class contains routes that will create and get
 * new users
 */
import express, { Request, Response } from "express";
import multer from "multer";
import mongoose  from "mongoose";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { validateMentee, validateMentor } from "../middleware/validation";
import { createUser } from "../services/firebase/auth";
import { ValidationError } from "../errors/validationError";
import { validateAuthToken } from "../middleware/auth";

const router = express.Router();

const upload = multer({ storage: multer.memoryStorage() }).array("images");

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
 * This is a patch route to edit a mentee
 */
router.patch("/mentee/:userId", [validateAuthToken, upload], 
async (req: Request, res: Response) => {
  console.log("Editing a mentee");
  try {
    const userId = new mongoose.Types.ObjectId(req.params.userId);
    for(const property in req.body) {
      
    }

  } catch (e) {

  }
})

export { router as userRouter };
