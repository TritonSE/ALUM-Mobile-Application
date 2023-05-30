/**
 * This file will contain helper functions pertaining to user routes
 */
import { Request } from "express";
import mongoose from "mongoose";
import { Image } from "../models/image";
import { InternalError } from "../errors";
import { Pairing } from "../models/pairing";
import { UpdateMenteeRequestBodyType, UpdateMentorRequestBodyType } from "../types";
import { Mentor } from "../models/mentor";
import { Mentee } from "../models/mentee";
import { ServiceError } from "../errors";

async function saveImage(req: Request): Promise<mongoose.Types.ObjectId> {
  console.info("Adding an image to the datatbase");
  console.log(req.file?.mimetype);
  const image = new Image({
    buffer: req.file?.buffer,
    originalname: req.file?.originalname,
    mimetype: req.file?.mimetype,
    encoding: req.file?.encoding,
    size: req.file?.size,
  });
  try {
    const newImage = await image.save();
    return newImage._id;
  } catch (e) {
    throw ServiceError.IMAGE_NOT_SAVED;
  }
}

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

async function updateMentor(updatedMentor: UpdateMentorRequestBodyType, userID: String) {
  console.log("updatedMentor", updatedMentor);
  let mentor = await Mentor.findById(userID);
  if (!mentor) {
    throw ServiceError.MENTOR_WAS_NOT_FOUND;
  }

  try {
    if(mentor != null){
      mentor.name = updatedMentor.name;
      mentor.imageId = updatedMentor.imageId;
      mentor.about = updatedMentor.about;
      mentor.calendlyLink = updatedMentor.calendlyLink;
      mentor.graduationYear = updatedMentor.graduationYear;
      mentor.college = updatedMentor.college;
      mentor.major = updatedMentor.major;
      mentor.minor = updatedMentor.minor;
      mentor.career = updatedMentor.career;
      mentor.topicsOfExpertise = updatedMentor.topicsOfExpertise;
      mentor.mentorMotivation = updatedMentor.mentorMotivation;
      mentor.location = updatedMentor.location;
      console.log(mentor);
      return await mentor.save();
    }
  } catch (error) {
    throw ServiceError.MENTOR_WAS_NOT_SAVED;
  }
}

async function updateMentee(updatedMentee: UpdateMenteeRequestBodyType, userID: String) {
  console.log("updatedMentee", updatedMentee);
  let mentee = await Mentee.findById(userID);
  if (!mentee) {
    throw ServiceError.MENTEE_WAS_NOT_FOUND;
  }

  try {
    if(mentee != null){
      mentee.name = updatedMentee.name;
      mentee.grade = updatedMentee.grade;
      mentee.imageId = updatedMentee.imageId;
      mentee.topicsOfInterest = updatedMentee.topicsOfInterest;
      mentee.careerInterests = updatedMentee.careerInterests;
      mentee.mentorshipGoal = updatedMentee.mentorshipGoal;
      console.log(mentee);
      return await mentee.save();
    }
  } catch (error) {
    throw ServiceError.MENTEE_WAS_NOT_SAVED;
  }
}

export { getMentorId, getMenteeId, updateMentor, updateMentee };
