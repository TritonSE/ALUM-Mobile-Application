// import express, { Request, Response } from "express";
// import { User } from "../models/users";

// const router = express.Router();

// router.post("/user", async (req: Request, res: Response) => {
//   const { name, email } = req.body;
//   const user = new User({ name, email });
//   await user.save();
//   return res.status(201).send(user);
// });

// router.get("/user/:userid", [], async (req: Request, res: Response) => {
//   const userid = req.params.userid;
//   const user = await User.find({ _id: userid });
//   return res.status(200).send(user);
// });

// export { router as userRouter };
