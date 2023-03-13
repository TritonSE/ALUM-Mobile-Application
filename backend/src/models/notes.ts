/**
 * This file contains the model for the Notes.
 */
import mongoose from "mongoose";
import {Answer} from "../services/note"

interface NoteInterface {
  answers: Answer[];
  type: string;
}

interface NoteDoc extends mongoose.Document {
  answers: Answer[];
  type: string;
}

interface NoteModelInterface extends mongoose.Model<NoteDoc> {
  build(attr: NoteInterface): NoteDoc;
}

const NoteSchema = new mongoose.Schema({
  answers: {
    type: [],
    required: true,
  },
  type: {
    type: String,
    required: true,
  },
});

const Note = mongoose.model<NoteDoc, NoteModelInterface>("Note", NoteSchema);

export { Note, NoteSchema };
