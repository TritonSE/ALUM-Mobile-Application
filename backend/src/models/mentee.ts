import mongoose from "mongoose";

interface MenteeInterface {
  name: string;
  imageId: string;
  about: string;
  grade: number;
  topicsOfInterest: string[];
  careerInterests: string[];
  mentorshipGoal: string;
  pairingId: string;
  status: string;
}

interface MenteeDoc extends mongoose.Document {
  name: string;
  imageId: string;
  about: string;
  grade: number;
  topicsOfInterest: string[];
  careerInterests: string[];
  mentorshipGoal: string;
  pairingId: string;
  status: string;
}

interface MenteeModelInterface extends mongoose.Model<MenteeDoc> {
  build(attr: MenteeInterface): MenteeDoc;
}

const MenteeSchema = new mongoose.Schema({
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
  grade: {
    type: Number,
    required: true,
  },
  topicsOfInterest: [
    {
      type: String,
      required: true,
    },
  ],
  careerInterests: [
    {
      type: String,
      required: true,
    },
  ],
  mentorshipGoal: {
    type: String,
    required: true,
  },
  pairingId: {
    type: String,
    required: false,
  },
  status: {
    type: String,
    required: true,
  },
});

const Mentee = mongoose.model<MenteeDoc, MenteeModelInterface>("Mentee", MenteeSchema);

export { Mentee, MenteeSchema };
