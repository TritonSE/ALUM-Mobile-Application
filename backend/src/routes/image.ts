/**
 * This file contains all routes pertaining to images
 */

import express, { Request, Response } from "express";
import { Image } from "../models/image";
import { saveImage, getImage }  from "../services/user";
import { verifyAuthToken }  from "../middleware/auth";
import mongoose from "mongoose";

const router = express.Router();

/**
 * This route allows users to get an image. Note that there is only a validation
 * to ensure the person using the route is a proper user and no check to make sure
 * the image requested belongs to a certain person
 */
router.get("image/:imageId", [verifyAuthToken], async (req: Request, res: Response) => {
    const imageId = req.params.imageId;
    if(!mongoose.Types.ObjectId.isValid(imageId)){
        return res.status(401).send("Invalid image id");
    }

    try {
        const image = await Image.findById(imageId);
        if(!image) {
            throw Error("Image was not found");
        }
        return res.status(201).set('Content-type', image.mimetype).send(image.buffer);
    } catch (e) {
        console.log("Error obtaining image");
        console.log(e);
    }
});

export { router as imageRouter };