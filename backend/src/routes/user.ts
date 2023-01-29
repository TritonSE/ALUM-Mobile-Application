import express, { Request, Response } from "express";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";

const router = express.Router();

router.post("/user", /* insert validator */ async (req: Request, res: Response) => {
    if(!req.body.access_token && !req.body.organization_id){
        const {name, status} = req.body;
        const mentee = new Mentee({name, status});
        await mentee.save();
        // const uid = mentee._id;
        // console.log(uid);
        return res.status(201).send(mentee);
    }
    else{
    const {name, organization_id, access_token, status} = req.body;
    const mentor = new Mentor({ name, organization_id, access_token, status});
    await mentor.save();
    return res.status(201).send(mentor);
    }
});

router.get("/user/:userid", [], async (req: Request, res: Response) => {
  const userid = req.params.userid;
  const user = await Mentor.find({ _id: userid });
  return res.status(200).send(user);
});

export { router as userRouter };
