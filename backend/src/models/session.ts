/**
 * This file contains the model for the Sessions. Note
 * personal information such as email and password will
 * be stored on firebase
 */
import mongoose, { ObjectId } from "mongoose";

interface SessionInterface {
  preSession: ObjectId;
  postSession: ObjectId;
  menteeId: ObjectId;
  mentorId: ObjectId;
  dateTime: Date;
}

interface SessionDoc extends mongoose.Document {
  preSession: ObjectId;
  postSession: ObjectId;
  menteeId: ObjectId;
  mentorId: ObjectId;
  dateTime: Date;
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
  dateTime: {
    type: Date,
    required: true,
  },
});

const Session = mongoose.model<SessionDoc, SessionModelInterface>("Session", SessionSchema);

export { Session, SessionSchema };
