/**
 * This file contains the model to store image metadata.
 * Note that images require refactoring via the multer package
 */

import mongoose from "mongoose";

interface ImageInterface {
  buffer: Buffer;
  originalname: string;
  mimetype: string;
  encoding: string;
  size: Number;
}

interface ImageDoc extends mongoose.Document {
  buffer: Buffer;
  originalname: string;
  mimetype: string;
  encoding: string;
  size: Number;
}

interface ImageModelInterface extends mongoose.Model<ImageDoc> {
  build(attr: ImageInterface): ImageDoc;
}

const imageSchema = new mongoose.Schema({
  buffer: {
    type: Buffer,
    requried: true
  },
  originalname: {
    type: String,
    required: true
  },
 mimetype: {
    type: String,
    required: true
  },
  encoding: {
    type: String,
    required: true,
  }, 
  size: {
    type: Number,
    required: true
  }
});

const Image = mongoose.model<ImageDoc, ImageModelInterface>("Image", imageSchema);

export { Image, imageSchema };