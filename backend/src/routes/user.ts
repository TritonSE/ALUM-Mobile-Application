/**
 * This file contains routes that will create and get
 * new users
 */
import express, { Request, Response } from "express";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { validateMentee, validateMentor } from "../middleware/validation";
import { createUser, decodeAuthToken } from "../services/auth";
import { ValidationError } from "../errors/validationError";
import { saveImage, getImage }  from "../services/user";
import { verifyAuthToken }  from "../middleware/auth";
import multer from "multer";
import { defaultImageID } from "../config";
import { Image } from "../models/image";
import mongoose from "mongoose";

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
    const imageId = defaultImageID;
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
    await createUser(mentee._id.toString(), email, password, 'mentee');
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
    const imageId = defaultImageID;
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
    await createUser(mentor._id.toString(), email, password, 'mentor');
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
router.get("/mentee/:userId", [verifyAuthToken, upload], async (req: Request, res: Response) => {
  const userId = req.params.userId;
  if(!mongoose.Types.ObjectId.isValid(userId)) {
    return res.status(401).send("Invalid id");
  }
  const role = req.body.role;

  if(role === "mentee") {
    try {
      const mentee = await Mentee.findById(userId);
      if(!mentee) {
        throw Error("Mentee was not found");
      }
      return res.status(201).send(
        {
          message: `Here is mentee ${mentee.name}`,
          mentee: mentee
        }
      );
    } catch (e) {
      console.log("Error getting mentee")
      console.log(e);
    }
  } 

  if(role === "mentor") {
    try {
      const mentee = await Mentee.findById(userId);
      if(!mentee) {
        throw Error("Mentee was not found");
      }
      const { name, imageId, about, grade, topicsOfInterest, careerInterests } = mentee;
      return res.status(201).send(
        {
          message: `Here is mentee ${mentee.name}`,
          mentee: {
            name: name,
            imageId: imageId,
            about: about,
            grade: grade,
            topicsOfInterest: topicsOfInterest,
            careerInterests: careerInterests
          }
        }
      );
    } catch (e) {
      console.log("Error getting mentee");
      console.log(e);
    }
  }
  
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
router.get("/mentor/:userId", [verifyAuthToken, upload], async (req: Request, res: Response) => {
  const userId = req.params.userId;
  if(!mongoose.Types.ObjectId.isValid(userId)) {
    return res.status(401).send("Invalid id");
  }
  const role = req.body.role;

  if(role === "mentee") {
    try {
      const mentor = await Mentor.findById(userId);
      if(!mentor) {
        throw Error("Mentee was not found");
      }
      const { name, 
        imageId,
        about, 
        major, 
        minor, 
        college, 
        career, 
        graduationYear, 
        calendlyLink,
        topicsOfExpertise } = mentor;
      return res.status(201).send(
        {
          message: `Here is mentor ${mentor.name}`,
          mentor: {
            name: name,
            imageId: imageId,
            major: major,
            minor: minor,
            college: college,
            career: career,
            graduationYear: graduationYear,
            calendlyLink: calendlyLink,
            topicsOfExpertise: topicsOfExpertise
          }
        }
      );
    } catch (e) {
      console.log("Error getting mentee")
      console.log(e);
    }
  } 

  if(role === "mentor") {
    try {
      const mentor = await Mentor.findById(userId);
      if(!mentor) {
        throw Error("Mentee was not found");
      }
      return res.status(201).send(
        {
          message: `Here is mentor ${mentor.name}`,
          mentor: mentor
        }
      );
    } catch (e) {
      console.log("Error getting mentee");
      console.log(e);
    }
  }
});

export { router as userRouter };
