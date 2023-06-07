/**
 * This file contains all routes pertaining to images
 */

import express, { NextFunction, Request, Response } from "express";
import mongoose from "mongoose";
import multer = require("multer");
import { Image } from "../models";
import { verifyAuthToken } from "../middleware/auth";
import { ServiceError } from "../errors/service";
import { InternalError } from "../errors/internal";
import { saveImage } from "../services/user";

const router = express.Router();
const upload = multer();

/**
 * This route allows users to get an image. Note that there is only a validation
 * to ensure the person using the route is a proper user and no check to make sure
 * the image requested belongs to a certain person
 */
router.get("/image/:imageId", [verifyAuthToken], async (req: Request, res: Response, next: NextFunction) => {
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
      next(e);
    }
    return res
      .status(InternalError.ERROR_GETTING_IMAGE.status)
      .send(InternalError.ERROR_GETTING_IMAGE.displayMessage(true));
  }
});

router.post(
  "/image",
  [verifyAuthToken],
  upload.single("image"),
  async (req: Request, res: Response) => {
    try {
      console.log("POST /image", req.file);
      const imageId = await saveImage(req);
      console.log("imageId", imageId);
      return res.status(200).send({ imageId });
    } catch (e) {
      console.log(e);
      if (e instanceof ServiceError) {
        return res.status(e.status).send(e.displayMessage(true));
      }
      return res
        .status(ServiceError.IMAGE_NOT_FOUND.status)
        .send(ServiceError.IMAGE_NOT_FOUND.displayMessage(true));
    }
  }
);

export { router as imageRouter };
