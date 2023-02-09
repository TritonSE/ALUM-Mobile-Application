/**
 * This class contains routes that will create and get 
 * new users
 */
import express, { NextFunction, Request, Response } from "express";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { validateMentee, validateMentor } from "../middleware/validation";
import { createUser } from "../services/auth";
import { firebaseAuth } from "../services/firebase";
import { nextTick } from "process";

const router = express.Router();

/**
 * This is a post route to create a new mentee. It will first validate 
 * the mentee to ensure they follow standard listed below before adding them to
 * mongoDb and Firebase
 * 
 * Mentee: {type: string, name: string, email: string,password: string}
 */
router.post("/mentee", [validateMentee], async (req: Request, res: Response, next: NextFunction) => {
  /*
   * When registering a mentee
   */
  console.log('Creating a new mentee', req.query);

  try {
    const { name, email, password } = req.body;
    const status = "under review";
    const mentee = new Mentee({ name, status });
    await createUser(mentee._id.toString(), email, password);
    await mentee.save();
    return res.status(201).json({
      message: `Mentee ${name} was succesfully created.`,
      userID: mentee._id,
    });
  }
  catch (e) {
    next();
    return;
  }
});

/**
 * This is a post route to create a new mentor. It will first validate 
 * the mentor to ensure they follow standard listed below before adding them to
 * mongoDb and Firebase
 * 
 * Mentor: {type: string, name: string, email: string, password: string
 * organization_id: string, personal_access_token: string}
 */

router.post("/mentor", [validateMentor], async (req: Request, res: Response, next: NextFunction) => {
  /*
  * When registering a mentor
  */

  console.info('Creating new mentor', req.query);
  try {
    const { name, email, password, organization_id, personal_access_token } = req.body;
    const status = "under review";
    const mentor = new Mentor({ name, organization_id, personal_access_token, status });
    await createUser(mentor._id.toString(), email, password);
    await mentor.save();
    return res.status(201).json({
      message: `Mentor ${name} was successfully created.`,
      userID: mentor._id,
    });
  }
  catch (e) {
    next();
    return;
  }
});



router.patch("/mentee/:userid", [], async (req: Request, res: Response, next: NextFunction) => {
  const requestBody = req.body;
  const userid = req.params.userid;

  if (requestBody.type == "Mentor") {
    const user = await Mentor.find({ _id: userid });
    return res.status(200).send(user);
  }
  else {
    const user = await Mentee.find({ _id: userid });
    return res.status(200).send(user);
  }
});

export { router as userRouter };
