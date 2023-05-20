/**
 * This file contains the model for the Sessions. Note
 * personal information such as email and password will
 * be stored on firebase
 */
import mongoose, { ObjectId } from "mongoose";

interface SessionInterface {
  preSession: ObjectId;
  postSessionMentee: ObjectId;
  postSessionMentor: ObjectId;
  menteeId: ObjectId;
  mentorId: ObjectId;
  dateTime: Date;
  startTime: Date;
  endTime: Date;
  calendlyUri: string;
  preSessionCompleted: boolean;
  postSessionMentorCompleted: boolean;
  postSessionMenteeCompleted: boolean;
}

interface SessionDoc extends mongoose.Document {
  preSession: ObjectId;
  postSessionMentee: ObjectId;
  postSessionMentor: ObjectId;
  menteeId: ObjectId;
  mentorId: ObjectId;
  startTime: Date;
  endTime: Date;
  calendlyUri: string;
  preSessionCompleted: boolean;
  postSessionMentorCompleted: boolean;
  postSessionMenteeCompleted: boolean;
}

interface SessionModelInterface extends mongoose.Model<SessionDoc> {
  build(attr: SessionInterface): SessionDoc;
}

const SessionSchema = new mongoose.Schema({
  preSession: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
  postSessionMentee: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
  postSessionMentor: {
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
  },
  preSessionCompleted: {
    type: Boolean,
    required: true,
  },
  postSessionMentorCompleted: {
    type: Boolean,
    required: true,
  },
  postSessionMenteeCompleted: {
    type: Boolean,
    required: true,
  },
});

const Session = mongoose.model<SessionDoc, SessionModelInterface>("Session", SessionSchema);

export { Session, SessionSchema };
