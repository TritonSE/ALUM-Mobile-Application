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

userSchema.statics.build = (attr: UserInterface) => new User(attr);

const User = mongoose.model<UserDoc, UserModelInterface>("User", userSchema);

export { User, userSchema };
