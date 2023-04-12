import { createHash } from "crypto";
import preSessionQuestions from "../models/preQuestionsList.json";
import postSessionQuestions from "../models/postQuestionsList.json";
import { Note } from "../models/notes";
import { AnswerType, QuestionType, UpdateNoteDetailsType } from "../types/notes";

interface Question {
  question: string;
  type: string;
}

/*
 * Class definition for an Answer to a question, can either be textbox or bullet boxes.
 */
class Answer implements AnswerType {
  answer: string | Array<string>;

  type: string;

  id: string;

  toObject(): AnswerType {
    return { answer: this.answer, type: this.type, id: this.id };
  }

  constructor(type: string, id: string) {
    if (type === "text") {
      this.answer = "";
    } else {
      this.answer = new Array<string>();
    }
    this.type = type;
    this.id = id;
  }
}

/**
 * Function for hashing questions to link them to their answer.
 * @param str: Question+type of question to be hashed
 * @returns: Hash value of the question+type
 */
function hashCode(str: string) {
  return createHash("sha256").update(str).digest("hex");
}

/**
 * Creates an array of Answer objects from a list of questions and their types.
 * @param questions List of questions (in JSON form) to generate answer array from
 * @returns The created answer array.
 */

function createAnswerArray(questions: QuestionType[]): AnswerType[] {
  const answerList: AnswerType[] = new Array(questions.length);
  for (let i = 0; i < answerList.length; ++i) {
    const questionID = hashCode(questions[i].question+questions[i].type);
    answerList[i] = new Answer(
      questions[i].type,
      questionID
    );
  }
  return answerList;
}

function fillHashMap(questions: Question[], map: Map<String, String>): void{
  for(let i=0; i<questions.length; ++i){
    const questionID = hashCode(questions[i].question+questions[i].type);
    if(!map.has(questionID)){
      map.set(questionID, questions[i].question);
    }
  }
}

/**
 * Stores pre-session answers document in MongoDB
 */
async function createPreSessionNotes() {
  let preNotes = null;
  try {
    const preSessionAnswers = createAnswerArray(preSessionQuestions);
    preNotes = new Note({ answers: preSessionAnswers, type: "pre" });
    return await preNotes.save();
  } catch (e) {
    throw new Error("Unable to create notes!");
  }
}

/**
 * Stores post-session answers document in MongoDB
 */
async function createPostSessionNotes() {
  let postNotes = null;
  try {
    const postSessionAnswers = createAnswerArray(postSessionQuestions);
    postNotes = new Note({ answers: postSessionAnswers, type: "post" });
    return await postNotes.save();
  } catch (e) {
    throw new Error("Unable to create notes!");
  }
}

/**
 * Updates notes document inside of MongoDB
 * @param updatedNotes New notes document with new answers to replace original document
 * @param documentId ObjectID of the document to be updated
 * @returns Updated note document w/ new answers
 * @throws Error if there was a problem saving the notes
 */
async function updateNotes(updatedNotes: UpdateNoteDetailsType[], documentId: string) {
  console.log("updatedNotes", updatedNotes);
  const noteDoc = await Note.findById(documentId);
  if (!noteDoc) {
    throw new Error("Document not found");
  } else {
    // Can improve this in future if needed by creating a hashmap
    noteDoc.answers.forEach((_, answerIndex) => {
      const updatedNote = updatedNotes.find(
        (note) => note.question_id === noteDoc.answers[answerIndex].id
      );
      if (updatedNote) {
        noteDoc.answers[answerIndex].answer = updatedNote.answer;
      }
    });
    try {
      // Since we are modifying noteDoc.answers[index].answer directly,
      // mongoose does not notice the change so ignores saving it unless we manually mark
      noteDoc.markModified("answers");
      return await noteDoc.save();
    } catch (error) {
      console.error(error);
      throw new Error("Save error");
    }
  }
}

export { createPreSessionNotes, createPostSessionNotes, updateNotes, Answer, fillHashMap };
