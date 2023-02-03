/**
 * This class contains routes that will create and get 
 * new users
 */
import express, { Request, Response } from "express";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";
import { validateUsers } from "../middleware/validation";

const router = express.Router();

/**
 * This is a post route to create a new user. It will first validate 
 * the users to ensure they follow standard listed below before adding them to
 * mongoDb and Firebase
 * 
 * Mentee: {type: string, name: string, password: string}
 * 
 * Mentor: {type: string, name: string, password: string, 
 * organization_id: string, personal_access_token: string}
 */
router.post("/user", [validateUsers], async (req: Request, res: Response) => {
    const requestBody = req.body;
    /**
     * When registering a mentor
     */
    if(requestBody.type === "Mentor"){
      const {name, status} = req.body;
      const mentee = new Mentee({name, status});
      await mentee.save();
      // const uid = mentee._id;
      // console.log(uid);
      return res.status(201).send(mentee);
       //return res.status(201).send("This is a mentor");
    }
    /**
     * When registering a mentee
     */
    else{
      const {name, organization_id, access_token, status} = req.body;
      const mentor = new Mentor({ name, organization_id, access_token, status});
      await mentor.save();
      return res.status(201).send(mentor);
      //return res.status(201).send("This is a mentee");
    }
});

router.get("/user/:userid", [], async (req: Request, res: Response) => {
  const userid = req.params.userid;
  const user = await Mentor.find({ _id: userid });
  return res.status(200).send(user);
});

export { router as userRouter };
