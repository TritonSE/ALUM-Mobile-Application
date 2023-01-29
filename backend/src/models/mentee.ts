import mongoose from "mongoose";

interface MenteeInterface {
    name: string;
    status: string;
}

interface MenteeDoc extends mongoose.Document {
  name: string;  
  status: string;
}

interface MenteeModelInterface extends mongoose.Model<MenteeDoc> {
  build(attr: MenteeInterface): MenteeDoc;
}

const MenteeSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true,
    },
  status: {
    type: String,
    required: true,
  }
});

const Mentee = mongoose.model<MenteeDoc, MenteeModelInterface>("Mentee", MenteeSchema);

export { Mentee, MenteeSchema };
