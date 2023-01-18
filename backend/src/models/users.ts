import { AnyTxtRecord } from 'dns';
import mongoose from 'mongoose';

interface userInterface{
    name: String;
    email: String;
}

interface UserDoc extends mongoose.Document{
    name: String; 
    email: String;
}

interface userModelInterface extends mongoose.Model<UserDoc> {
    build(attr: userInterface): UserDoc
}


const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    }
})

userSchema.statics.build = (attr: userInterface) => {
    return new User(attr)
}

const User = mongoose.model<UserDoc, userModelInterface>('User', userSchema)

User.build({
    name: "Adhithya",
    email: "Ad@gmail.com"
})

User.build({
    name: "Christen",
    email: "ch@gmail.com"
})

export { User }

