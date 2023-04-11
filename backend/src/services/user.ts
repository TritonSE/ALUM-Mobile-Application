/**
 * This file will contain helper functions pertaining to user routes
 */
import { Request } from "express";
import mongoose from "mongoose";
import { Image } from "../models/image";
import { ServiceError } from "../errors/service";

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

export { saveImage };
