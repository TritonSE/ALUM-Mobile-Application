/**
 * This file contains the model for the Sessions. Note
 * personal information such as email and password will
 * be stored on firebase
 */
import mongoose, { ObjectId } from "mongoose";

interface SessionInterface {
  preSession: ObjectId;
  postSession: ObjectId;
  menteeId: string;
  mentorId: string;
  startTime: Date;
  endTime: Date;
  calendlyUri: string;
}

interface SessionDoc extends mongoose.Document {
  preSession: string;
  postSession: string;
  menteeId: ObjectId;
  mentorId: ObjectId;
  startTime: Date;
  endTime: Date;
  calendlyUri: string;
}

interface SessionModelInterface extends mongoose.Model<SessionDoc> {
  build(attr: SessionInterface): SessionDoc;
}

const SessionSchema = new mongoose.Schema({
  preSession: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
  postSession: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
  menteeId: {
    type: String,
    required: true,
  },
  mentorId: {
    type: String,
    required: true,
  },
  startTime: {
    type: Date,
    required: true,
  },
  endTime: {
    type: Date,
    required: true,
  },
  calendlyUri: {
    type: String,
    required: true,
  }
});

const Session = mongoose.model<SessionDoc, SessionModelInterface>("Session", SessionSchema);

export { Session, SessionSchema };
