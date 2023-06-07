/**
 * This file will contain helper functions pertaining to user routes
 */
import { Request } from "express";
import mongoose from "mongoose";
import { Image } from "../models/image";
import { InternalError, ServiceError } from "../errors";
import { Pairing } from "../models/pairing";
import { UpdateMenteeRequestBodyType, UpdateMentorRequestBodyType } from "../types";
import { Mentor } from "../models/mentor";
import { Mentee } from "../models/mentee";
import { validateCalendlyAccessToken, validateCalendlyLink } from "./calendly";

async function saveImage(req: Request): Promise<mongoose.Types.ObjectId> {
  console.info("Adding an image to the datatbase");
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
async function updateMentor(updatedMentor: UpdateMentorRequestBodyType, userID: string) {
  console.log("updatedMentor", updatedMentor);
  const mentor = await Mentor.findById(userID);
  if (!mentor) {
    throw ServiceError.MENTOR_WAS_NOT_FOUND;
  }
  await validateCalendlyAccessToken(updatedMentor.personalAccessToken);
  await validateCalendlyLink(updatedMentor.calendlyLink);
  try {
    if (mentor != null) {
      return await Mentor.findByIdAndUpdate({ _id: userID }, updatedMentor);
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
async function updateMentee(updatedMentee: UpdateMenteeRequestBodyType, userID: string) {
  console.log("updatedMentee", updatedMentee);
  const mentee = await Mentee.findById(userID);
  if (!mentee) {
    throw ServiceError.MENTEE_WAS_NOT_FOUND;
  }

  try {
    if (mentee != null) {
      return Mentee.findByIdAndUpdate({ _id: userID }, updatedMentee);
    }
  } catch (error) {
    throw ServiceError.MENTEE_WAS_NOT_SAVED;
  }
}

export { getMentorId, getMenteeId, updateMentor, updateMentee, saveImage };
