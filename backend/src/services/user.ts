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
import { validateCalendlyAccessToken } from "../services/calendly";

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

/**
 * Updates a mentor entry
 * @param updatedMentor - updated values for mentor
 * @param userID - uid of mentor to update
 * @returns Updated saved mentor
 */
async function updateMentor(updatedMentor: UpdateMentorRequestBodyType, userID: String) {
  console.log("updatedMentor", updatedMentor);
  const mentor = await Mentor.findById(userID);
  if (!mentor) {
    throw ServiceError.MENTOR_WAS_NOT_FOUND;
  }
  try {
    if(mentor != null){
      await validateCalendlyAccessToken(updatedMentor.personalAccessToken)
      mentor.name = updatedMentor.name;
      mentor.markModified("name");
      mentor.imageId = updatedMentor.imageId;
      mentor.markModified("imageId");
      mentor.personalAccessToken = updatedMentor.personalAccessToken;
      mentor.markModified("personalAccessToken");
      mentor.about = updatedMentor.about;
      mentor.markModified("about");
      mentor.calendlyLink = updatedMentor.calendlyLink;
      mentor.markModified("calendlyLink");
      mentor.graduationYear = updatedMentor.graduationYear;
      mentor.markModified("graduationYear");
      mentor.college = updatedMentor.college;
      mentor.markModified("college");
      mentor.major = updatedMentor.major;
      mentor.markModified("major");
      mentor.minor = updatedMentor.minor;
      mentor.markModified("minor");
      mentor.career = updatedMentor.career;
      mentor.markModified("career");
      mentor.topicsOfExpertise = updatedMentor.topicsOfExpertise;
      mentor.markModified("topicsOfExpertise");
      mentor.mentorMotivation = updatedMentor.mentorMotivation;
      mentor.markModified("mentorMotivation");
      mentor.location = updatedMentor.location;
      mentor.markModified("location");
      mentor.zoomLink = updatedMentor.zoomLink;
      mentor.markModified("zoomLink");
      console.log(mentor);
      return await mentor.save()
    }
  } catch (error) {
    throw ServiceError.MENTOR_WAS_NOT_SAVED;
  }
}

/**
 * Updates a mentor entry
 * @param updatedMentee - updated values for the mentee
 * @param userID - uid of mentee to update
 * @returns Updated saved mentee
 */
async function updateMentee(updatedMentee: UpdateMenteeRequestBodyType, userID: String) {
  console.log("updatedMentee", updatedMentee);
  const mentee = await Mentee.findById(userID);
  if (!mentee) {
    throw ServiceError.MENTEE_WAS_NOT_FOUND;
  }

  try {
    if(mentee != null){
      mentee.name = updatedMentee.name;
      mentee.markModified("name");
      mentee.grade = updatedMentee.grade;
      mentee.markModified("grade");
      mentee.about = updatedMentee.about;
      mentee.markModified("about")
      mentee.imageId = updatedMentee.imageId;
      mentee.markModified("imageId");
      mentee.topicsOfInterest = updatedMentee.topicsOfInterest;
      mentee.markModified("topicsOfInterest");
      mentee.careerInterests = updatedMentee.careerInterests;
      mentee.markModified("careerInterests");
      mentee.mentorshipGoal = updatedMentee.mentorshipGoal;
      mentee.markModified("mentorshipGoal");
      console.log(mentee);
      return await mentee.save();
    }
  } catch (error) {
    throw ServiceError.MENTEE_WAS_NOT_SAVED;
  }
}

export { getMentorId, getMenteeId, updateMentor, updateMentee };
