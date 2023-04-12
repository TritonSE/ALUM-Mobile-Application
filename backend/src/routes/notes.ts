import express, { NextFunction, Request, Response } from "express";
import { Note } from "../models/notes";
import  {questionIDs } from "../app";

const router = express.Router();

interface NoteItem {
  answer: any[] | string;
  type: string;
  id: string;
  question: string;
}


router.get("/notes/:id", async (req: Request, res: Response, next: NextFunction) => {
  try {
    console.log("Getting...");
    const id = req.params.id;
    const note = await Note.findById(id);
    if (note == null) {
      throw new Error();
    }
    const notes : NoteItem[] = note.answers as NoteItem[];
    notes.forEach((note) => {
      note.question=questionIDs.get(note.id) ?? "";
    });
    return res.status(200).json(note.answers);
  } catch (e) {
    next(e);
    return res.status(400).json({
      message: "Invalid ID!",
    });
  }
});

export { router as notesRouter };
