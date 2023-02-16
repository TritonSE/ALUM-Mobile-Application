/**
 * This is an example model file to be used as a reference
 * for creating future models.
 */

import mongoose from "mongoose";

interface UserInterface {
  name: string;
  email: string;
}

interface UserDoc extends mongoose.Document {
  name: string;
  email: string;
}

interface UserModelInterface extends mongoose.Model<UserDoc> {
  build(attr: UserInterface): UserDoc;
}

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
});

const User = mongoose.model<UserDoc, UserModelInterface>("User", userSchema);

export { User, userSchema };
