/**
 * This file contains a model to store images
 */

import mongoose from "mongoose";

interface ImageInterface {
  buffer: Buffer;
  originalname: string;
  mimetype: string;
  encoding: string;
  size: number;
}

interface ImageDoc extends mongoose.Document {
  buffer: Buffer;
  originalname: string;
  mimetype: string;
  encoding: string;
  size: number;
}

interface ImageModelInterface extends mongoose.Model<ImageDoc> {
  build(attr: ImageInterface): ImageDoc;
}

const imageSchema = new mongoose.Schema({
  buffer: {
    type: Buffer,
    required: true,
  },
  originalname: {
    type: String,
    required: true,
  },
  mimetype: {
    type: String,
    required: true,
  },
  encoding: {
    type: String,
    required: true,
  },
  size: {
    type: Number,
    required: true,
  },
});

const Image = mongoose.model<ImageDoc, ImageModelInterface>("Imagae", imageSchema);

export { Image, imageSchema };
