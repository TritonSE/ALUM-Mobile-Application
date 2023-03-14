import express, { NextFunction, Request, Response } from "express";
import { Note } from "../models/notes";
import { updateNotes } from "../services/note";
import { validateReqBodyWithCake } from "../middleware/validation";
import { UpdateNoteRequestBodyCake } from "../types/cakes";
import { Infer } from "caketype";
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

type UpdateNoteRequestBodyType = Infer<typeof UpdateNoteRequestBodyCake>
router.patch(
  "/notes/:id", 
  validateReqBodyWithCake(UpdateNoteRequestBodyCake),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
        console.log("Patching...");
        const documentId = req.params.id;
        const updatedNotes: UpdateNoteRequestBodyType = req.body;
        await updateNotes(updatedNotes, documentId);
        console.log("##################");
        const noteDoc = await Note.findById(documentId);
        console.log(noteDoc?.answers);
        return res.status(200).json({
            message: "success",
            updatedDoc: noteDoc
        })
    }
    catch (e) {
        console.log(e);
        next(e);
        return res.status(400).json({
            message: "invalid"
        });
    }
})

export { router as notesRouter };
