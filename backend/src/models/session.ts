/**
 * This file contains the model for the Sessions. Note
 * personal information such as email and password will
 * be stored on firebase
 */
 import mongoose from "mongoose";


 interface SessionInterface {
    preSession: string;
    postSession: string;
    menteeId: string;
    mentorId: string;
    dateTime: Date;
 }
 
 interface SessionDoc extends mongoose.Document {
    preSession: string;
    postSession: string;
    menteeId: string;
    mentorId: string;
    dateTime: Date;
 }
 
 interface SessionModelInterface extends mongoose.Model<SessionDoc> {
   build(attr: SessionInterface): SessionDoc;
 }
 
 const SessionSchema = new mongoose.Schema({
   preSession: {
     type: String,
     required: true,
   },
   postSession: {
     type: String,
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
   }
 });
 
 const Session = mongoose.model<SessionDoc, SessionModelInterface>("Session", SessionSchema);
 
 export { Session, SessionSchema };
 