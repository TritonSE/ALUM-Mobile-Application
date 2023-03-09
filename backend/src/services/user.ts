/**
 * This file will contain helper functions pertaining to user routes
 */
import { Image } from '../models/image';
import { Request } from 'express';
import fileType from 'file-type'
import mongoose from 'mongoose';


async function saveImage(rawImage: Buffer, req: Request): Promise<mongoose.Types.ObjectId> {
    console.info("Adding an image to the datatbase");
    const fileResult = await fileType.fileTypeFromBuffer(rawImage);
    const image = new Image({
        buffer: rawImage.buffer,
        originalname: req.file?.originalname,
        mimetype: fileResult?.mime,
        encoding: fileResult?.ext,
        size: 

    })
}