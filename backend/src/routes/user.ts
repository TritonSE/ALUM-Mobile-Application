/**
 * This class contains routes that will create and get 
 * new users
 */
import express, { NextFunction, Request, Response } from "express";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { validateMentee, validateMentor } from "../middleware/validation";

const router = express.Router();

/**
 * This is a post route to create a new mentee. It will first validate 
 * the mentee to ensure they follow standard listed below before adding them to
 * mongoDb and Firebase
 * 
 * Mentee: {type: string, name: string, email: string,password: string}
 */
router.post("/mentee", [validateMentee], async (req: Request, res: Response) => {
  /*
   * When registering a mentee
   */
  const { name, status } = req.body;
  const mentee = new Mentee({ name, status });
  await mentee.save();
  return res.status(201).send(mentee);
});

/**
 * This is a post route to create a new mentor. It will first validate 
 * the mentor to ensure they follow standard listed below before adding them to
 * mongoDb and Firebase
 * 
 * Mentor: {type: string, name: string, password: string, email: string 
 * organization_id: string, personal_access_token: string}
 */

router.post("/mentor", [validateMentor], async (req: Request, res: Response) => {
  /*
  * When registering a mentor
  */
  const { name, organization_id, access_token, status } = req.body;
  const mentor = new Mentor({ name, organization_id, access_token, status });
  await mentor.save();
  return res.status(201).send(mentor);
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
