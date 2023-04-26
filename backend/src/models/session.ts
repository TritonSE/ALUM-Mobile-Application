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
}

interface SessionDoc extends mongoose.Document {
<<<<<<< HEAD
  preSession: string;
  postSessionMentee: string;
  postSessionMentor: string;
  menteeId: ObjectId;
  mentorId: ObjectId;
=======
  preSession: ObjectId;
  postSession: ObjectId;
  menteeId: string;
  mentorId: string;
>>>>>>> bde31717 (errors)
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
