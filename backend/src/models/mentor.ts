/**
 * This file contains the model for the mentors. Note
 * personal information such as email and password will
 * be stored on firebase
 */
import mongoose from "mongoose";
import { UserStatusType } from "../types";

interface MentorInterface {
  name: string;
  imageId: string;
  about: string;
  calendlyLink: string;
  graduationYear: number;
  college: string;
  major: string;
  minor: string;
  career: string;
  topicsOfExpertise: string[];
  mentorMotivation: string;
  pairingIds: string[];
  status: UserStatusType;
  personalAccessToken: string;
  location: string;
  fcmToken: string;
}

interface MentorDoc extends mongoose.Document {
  name: string;
  imageId: string;
  about: string;
  calendlyLink: string;
  graduationYear: number;
  college: string;
  major: string;
  minor: string;
  career: string;
  topicsOfExpertise: string[];
  mentorMotivation: string;
  pairingIds: string[];
  status: UserStatusType;
  personalAccessToken: string;
  location: string;
  fcmToken: string;
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
  pairingIds: [
    {
      type: String,
      required: false,
    },
  ],
  status: {
    type: String,
    enum: ["paired", "approved", "under review"],
    required: true,
  },
  personalAccessToken: {
    type: String,
    required: true,
  },
  location: {
    type: String,
    required: true,
  },
  fcmToken: {
    type: String,
    required: true,
  },
});

const Mentor = mongoose.model<MentorDoc, MentorModelInterface>("Mentor", mentorSchema);

export { Mentor, mentorSchema };
