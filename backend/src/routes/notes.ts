import express, { NextFunction, Request, Response } from "express";
import { Infer } from "caketype";
import { Note } from "../models/notes";
import { questionIDs } from "../config";
import { updateNotes } from "../services/note";
import { validateReqBodyWithCake } from "../middleware/validation";
import { UpdateNoteRequestBodyCake } from "../types/cakes";

const router = express.Router();

interface NoteItem {
  answer: any[] | string;
  type: string;
  id: string;
  question: string;
}

/**
 * @param id: ObjectID of the notes document to be retreived.
 * This route will get a note document and return it as a JSON in the form
 * [
    {
        question: "Question?",
        type: "text",
        id: "the hashed ID 1",
        answer: "",
    }, 
    {
        question: "Question?",
        type: "bullet",
        id: "the hashed ID 2",
        answer: []
     }
]
 */
router.get("/notes/:id", async (req: Request, res: Response, next: NextFunction) => {
  try {
    console.log("Getting...");
    const id = req.params.id;
    const note = await Note.findById(id);
    if (note == null) {
      throw new Error();
    }
    const notes: NoteItem[] = note.answers as NoteItem[];
    notes.forEach((note_answer) => {
      note_answer.question = questionIDs.get(note_answer.id) ?? "";
    });
    return res.status(200).json(note.answers);
  } catch (e) {
    next(e);
    return res.status(400).json({
      message: "Invalid ID!",
    });
  }
});

/**
 * * This route will update the answers of a single note document.
 * @param id: ObjectID of the notes document to be retreived.
 * @body The body should be a JSON in the form:
 * [
    {
        question_id: "the hashed ID 1",
        type: "bullet",
        answer: "updated answer"
    },
    {
        question_id: "the hashed ID 2",
        type: "bullet",
        answer: ["new answer1", "new answer2"]
    }
]
 * @response "Success" with new, updated note if successfully updated, "Invalid" otherwise.
 */
type UpdateNoteRequestBodyType = Infer<typeof UpdateNoteRequestBodyCake>;
router.patch(
  "/notes/:id",
  validateReqBodyWithCake(UpdateNoteRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const documentId = req.params.id;
      const updatedNotes: UpdateNoteRequestBodyType = req.body;
      await updateNotes(updatedNotes, documentId);
      const noteDoc = await Note.findById(documentId);
      return res.status(200).json({
        message: "Success",
        updatedDoc: noteDoc,
      });
    } catch (e) {
      console.log(e);
      next(e);
      return res.status(400).json({
        message: "Invalid",
      });
    }
  }
);

export { router as notesRouter };