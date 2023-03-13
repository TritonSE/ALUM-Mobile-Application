import express, { NextFunction, Request, Response } from "express";
import { Note } from "../models/notes";

const router = express.Router();

router.get("/notes/:id", async (req: Request, res: Response, next: NextFunction) => {
  try {
    console.log("Getting...");
    const id = req.params.id;
    const note = await Note.findById(id);
    if (note == null) {
      throw new Error(); 
    }
    return res.status(200).json(note.answers);
  } catch (e) {
    next(e);
    return res.status(400).json({
      message: "Invalid ID!",
    });
  }
});

export { router as notesRouter };
