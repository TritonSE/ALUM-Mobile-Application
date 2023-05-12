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
  menteeId: string;
  mentorId: string;
  dateTime: Date;
  preSessionCompleted: boolean;
  postSessionMentorCompleted: boolean;
  postSessionMenteeCompleted: boolean;
}

interface SessionDoc extends mongoose.Document {
  preSession: string;
  postSessionMentee: string;
  postSessionMentor: string;
  menteeId: ObjectId;
  mentorId: ObjectId;
  dateTime: Date;
  day: String;
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
    type: mongoose.Types.ObjectId,
    required: true,
  },
  mentorId: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
  dateTime: {
    type: Date,
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
