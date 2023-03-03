/**
 * This file contains helper functions pertaining to a user and
 * dealing with user (mentee and mentor) objects
 */

import { Request } from "express";
import mongoose from "mongoose";
import { Mentee } from "../models/mentee";
import { Mentor } from "../models/mentor";

/**
 * This function updates the various values of a mentee
 * @param userId: uid of a mentee
 * @param property: attribute being updating
 * @param value: value its being updated to
 * @param req: used for updating an image
 * @returns
 */
export async function updateMentee(
  userId: string,
  property: string,
  value: any,
  req?: Request
) {
  if (property !== "imageId") {
    try {
      const result = await Mentee.findByIdAndUpdate(userId, { $set: { [property]: value } }, { new: true });
      console.log(result);
      return;
    } catch (e) {
      // make custom error
      console.log("Error updating value");
      console.log(e);
      return;
    }
  }
  
}

/**
 * This function updates the various values of a mentee
 * @param userId: uid of a mentee
 * @param property: attribute being updating 
 * @param value: value its being updated to
 * @param req: used for updating an image
 * @returns 
 */
export async function updateMentor(
  userId: string,
  property: string,
  value: any,
  req?: Request
) {
  if (property !== "imageId") {
    try {
      const result = await Mentor.findByIdAndUpdate(userId, { $set: {[property]: value }}, { new: true });
      console.log(result);
      return;
    } catch (e) {
      console.log("Error updating value");
      console.log(e);
      return;
    }
  }

}
