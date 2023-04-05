/**
 * This file contains all routes pertaining to images
 */

import express, { Request, Response } from "express";
import mongoose from "mongoose";
import { Image } from "../models/image";
import { verifyAuthToken } from "../middleware/auth";
import { ServiceError } from "../errors/service";
import { InternalError } from "../errors/internal";

const router = express.Router();

/**
 * This route allows users to get an image. Note that there is only a validation
 * to ensure the person using the route is a proper user and no check to make sure
 * the image requested belongs to a certain person
 */
router.get("/image/:imageId", [verifyAuthToken], async (req: Request, res: Response) => {
  const imageId = req.params.imageId;
  if (!mongoose.Types.ObjectId.isValid(imageId)) {
    return res
      .status(ServiceError.INVALID_MONGO_ID.status)
      .send(ServiceError.INVALID_MONGO_ID.message);
  }

  try {
    const image = await Image.findById(imageId);
    if (!image) {
      throw ServiceError.IMAGE_NOT_FOUND;
    }
    return res.status(200).set("Content-type", image.mimetype).send(image.buffer);
  } catch (e) {
    console.log(e);
    if (e instanceof ServiceError) {
      return res.status(e.status).send(e.displayMessage(true));
    }
    return res
      .status(InternalError.ERROR_GETTING_IMAGE.status)
      .send(InternalError.ERROR_GETTING_IMAGE.displayMessage(true));
  }
});

export { router as imageRouter };
