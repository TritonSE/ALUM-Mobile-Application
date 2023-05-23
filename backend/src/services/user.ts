/**
 * This file will contain helper functions pertaining to user routes
 */
// import { Request } from "express";
// import mongoose from "mongoose";
// import { Image } from "../models/image";
import { InternalError } from "../errors";
import { Mentor , Mentee} from "../models";
import { Pairing } from "../models/pairing";
import { User } from "../models/users";
import { ServiceError } from "../errors";

// TODO need to add this back in when implementing EDIT profile
// async function saveImage(req: Request): Promise<mongoose.Types.ObjectId> {
//   console.info("Adding an image to the datatbase");
//   console.log(req.file?.mimetype);
//   const image = new Image({
//     buffer: req.file?.buffer,
//     originalname: req.file?.originalname,
//     mimetype: req.file?.mimetype,
//     encoding: req.file?.encoding,
//     size: req.file?.size,
//   });
//   try {
//     const newImage = await image.save();
//     return newImage._id;
//   } catch (e) {
//     throw ServiceError.IMAGE_NOT_SAVED;
//   }
// }

async function getMentorId(pairingId: string): Promise<string> {
  const pairing = await Pairing.findById(pairingId);
  if (!pairing) {
    throw InternalError.ERROR_FINDING_PAIR;
  }
  return pairing.mentorId;
}

async function getMenteeId(pairingId: string): Promise<string> {
  const pairing = await Pairing.findById(pairingId);
  if (!pairing) {
    throw InternalError.ERROR_FINDING_PAIR;
  }
  return pairing.menteeId;
}

async function updateMentorFCMToken(fcmToken: string, userId: string) {
  console.log("FCM Token: ", fcmToken);
  const user = await Mentor.findById(userId);
  if (!user) {
    throw ServiceError.MENTOR_WAS_NOT_FOUND;
  }
  
  try {
    user.fcmToken = fcmToken;
    return await user.save();
  } catch(error) {
    throw ServiceError.MENTOR_WAS_NOT_SAVED;
  }
}

async function updateMenteeFCMToken(fcmToken: string, userId: string) {
  console.log("FCM Token: ", fcmToken);
  const user = await Mentee.findById(userId);
  if (!user) {
    throw ServiceError.MENTEE_WAS_NOT_FOUND;
  }
  
  try {
    user.fcmToken = fcmToken;
    return await user.save();
  } catch(error) {
    throw ServiceError.MENTEE_WAS_NOT_SAVED;
  }
}

export { getMentorId, getMenteeId, updateMentorFCMToken, updateMenteeFCMToken };
