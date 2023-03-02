/**
 * This file contains the model for the mentors. Note
 * personal information such as email and password will
 * be stored on firebase
 */
import mongoose from "mongoose";

interface MentorInterface {
  name: string;
  imageId: string;
  about: string;
  calendlyLink: string;
  graduationYear: Number;
  college: string;
  major: string;
  minor: string;
  career: string;
  topicsOfExpertise: string[];
  mentorMotivation: string;
  menteeIDs: mongoose.Types.ObjectId[];
  organizationId: string;
  personalAccessToken: string;
  status: string;
}

interface MentorDoc extends mongoose.Document {
  name: string;
  imageId: string;
  about: string;
  calendlyLink: string;
  graduationYear: Number;
  college: string;
  major: string;
  minor: string;
  career: string;
  topicsOfExpertise: string[];
  mentorMotivation: string;
  menteeIDs: mongoose.Types.ObjectId[];
  organizationId: string;
  personalAccessToken: string;
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
  imageId: {
    type: String,
    required: true,
  },
  about: {
    type: String,
    required: true,
  },
  calendlyLink: {
    type: String,
    required: true,
  },
  graduationYear: {
    type: Number,
    required: true,
  },
  college: {
    type: String,
    required: true,
  },
  major: {
    type: String,
    required: true,
  },
  minor: {
    type: String,
    required: true,
  },
  career: {
    type: String,
    required: true,
  },
  topicsOfExpertise: [
    {
      type: String,
      required: true,
    },
  ],
  mentorMotivation: {
    type: String,
    required: true,
  },
  menteeIDs: [
    {
      type: mongoose.Types.ObjectId,
      required: false,
    },
  ],
  organizationId: {
    type: String,
    required: true,
  },
  personalAccessToken: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    required: true,
  },
});

const Mentor = mongoose.model<MentorDoc, MentorModelInterface>("Mentor", mentorSchema);

export { Mentor, mentorSchema };
