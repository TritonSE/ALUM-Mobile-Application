/**
 * This file contains routes that will create and get
 * sessions
 */

 import express, { NextFunction, Request, Response } from "express";
 import { createPreAnswerArray, createPostAnswerArray } from "../middleware/createNotes";
 import { Note } from "../models/notes";
 
 const router=express.Router();
 
 router.post( 
     "/notes",
     async (req: Request, res: Response, next: NextFunction) => {
       try{
         const preSessionAnswers = createPreAnswerArray();
         const preSessionNotes = new Note({preSessionAnswers, type : "pre" });
         const postSessionAnswers = createPostAnswerArray();
         const postSessionNotes = new Note({postSessionAnswers, type : "post"});
         await preSessionNotes.save();
         await postSessionNotes.save();
         const preNotesId=preSessionNotes._id;
         const postNotesId=postSessionNotes._id;
         return res.status(201).json({
           message: `PreSession notes ${preNotesId} and PostSession notes ${postNotesId}`,
           preId: preNotesId,
           postId: postNotesId
         });
       }
       catch(e){
         next();
         return res.status(400);
       }
     }
   );

 
 export {router as notesRouter}