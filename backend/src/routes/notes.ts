import express, { NextFunction, Request, Response } from "express";
import { Note } from "../models/notes";
import bodyParser from 'body-parser';
import { updateNotes } from "../services/note";

interface patchNote {
    question_id: string;
    type: string;
    answer: string | string[];
}

const router = express.Router();
router.use(bodyParser.json());

router.get("/notes/:id", async (req: Request, res: Response, next: NextFunction) => {
    console.log("Getting...");
    const id = req.params.id;
    const note = await Note.findById(id);
    if (note == null) {
        console.log("notfound");
        next();
        return res.status(400);
    }
    return res.status(200).json(
        note.answers
    )
});

router.patch("/notes/:id", async (req: Request, res: Response, next: NextFunction) => {
    try {
        console.log("Patching...");
        const documentId = req.params.id;
        const updatedNotes: patchNote[] = req.body;
        updateNotes(updatedNotes, documentId);
    }
    catch (e) {
        console.log(e);
        next(e);
        return res.status(400).json({
            message: "invalid"
        });
    }
    return res.status(200).json({
        message: "success"
    })
})

export { router as notesRouter, patchNote };
