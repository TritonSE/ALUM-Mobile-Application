/**
 * This file contains the model for the mentors. Note 
 * personal information such as email and password will
 * be stored on firebase
 */
import mongoose from "mongoose";

interface MentorInterface {
  name: string;
  organization_id: string;
  access_token: string;
  status: string;
}

interface MentorDoc extends mongoose.Document {
  name: string;
  organization_id: string;
  access_token: string;
  status: string;
}

interface MentorModelInterface extends mongoose.Model<MentorDoc> {
  build(attr: MentorInterface): MentorDoc;
}

const mentorSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  organization_id: {
    type: String,
    required: true,
  },
  access_token: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    required: true,
  }
});

const Mentor = mongoose.model<MentorDoc, MentorModelInterface>("Mentor", mentorSchema);

export { Mentor, mentorSchema };
