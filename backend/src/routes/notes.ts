import express, { NextFunction, Request, Response } from "express";
import { Infer } from "caketype";
import { Note } from "../models/notes";
import {Session} from "../models/session";
import { questionIDs } from "../config";
import {createPostSessionNotes, updateNotes} from "../services/note";
import { validateReqBodyWithCake } from "../middleware/validation";
import { UpdateNoteRequestBodyCake } from "../types/cakes";
import { CheckboxBullet } from "../types/notes";
import {ServiceError} from "../errors";

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
  try{
    const id = req.params.id;
    const note = await Note.findById(id);
<<<<<<< HEAD
    if (note === null) {
      throw new Error();
=======
    if (note == null) {
      return res.status(ServiceError.NOTE_WAS_NOT_FOUND.status)
          .send(ServiceError.NOTE_WAS_NOT_FOUND.message);
>>>>>>> bde31717 (errors)
    }
    if (note.type==="post"){
      const temp = await Session.findOne({postSession : id});
      if(temp == null){
        return res.status(ServiceError.SESSION_WAS_NOT_FOUND.status)
            .send(ServiceError.SESSION_WAS_NOT_FOUND);
      }
      else {
        const preSessionNotes = await Note.findById(temp.preSession);
        if(preSessionNotes==null){
          return res.status(ServiceError.NOTE_WAS_NOT_FOUND.status)
              .send(ServiceError.NOTE_WAS_NOT_FOUND.message);

        }
        else{
          const topicsToDiscuss = preSessionNotes.answers[0].answer;
          if(topicsToDiscuss instanceof Array){
            note.answers[0].type="CheckboxBullet";
            const topicsArray: CheckboxBullet[] = [];
            topicsToDiscuss.forEach((topic) => {
              if(typeof topic === "string") {
                let tempTopic: CheckboxBullet =
                {
                  content: topic,
                  status: "unchecked"
                };
               topicsArray.push(tempTopic);
              }
              });
            note.answers[0].answer=topicsArray;
          }
        }
      }
    }
    const notesAnswers: NoteItem[] = note.answers as NoteItem[];
    notesAnswers.forEach((note_answer) => {
      note_answer.question = questionIDs.get(note_answer.id) ?? "";
    });
    console.log(note.answers);
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
