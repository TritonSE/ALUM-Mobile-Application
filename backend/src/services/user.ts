/**
 * This file will contain helper functions pertaining to user routes
 */
import { Image } from '../models/image';
import { Request } from 'express';
import mongoose from 'mongoose';


async function saveImage(req: Request): Promise<mongoose.Types.ObjectId> {
    console.info("Adding an image to the datatbase");
    console.log(req.file?.mimetype); 
    const image = new Image({
        buffer: req.file?.buffer,
        originalname: req.file?.originalname,
        mimetype: req.file?.mimetype,
        encoding: req.file?.encoding,
        size: req.file?.size,
    })
    try {
        const newImage = await image.save();
        return newImage._id;
    } catch (e) {
        console.error(e);
        throw Error("There was some error");
    }

}

async function getImage(imageId: string): Promise<Object> {
    console.info("Getting an image");
    const image = await Image.findById(imageId);
    if(!image) {
        throw Error("Could not find image");
    }
    return image;
}

export { saveImage, getImage };