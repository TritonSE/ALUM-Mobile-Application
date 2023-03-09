import { assert } from "console";
import { createHash } from "crypto";
import preSessionQuestions from "../models/preQuestionsList.json";
import postSessionQuestions from "../models/postQuestionsList.json";
import { Note } from "../models/notes";

interface Question {
  question: string;
  type: string;
}

/*
 * Class definition for an Answer to a question, can either be textbox or bullet boxes.
 */
class Answer {
  answer: string | Array<string>;

  type: string;

  id: string; // hashed from question

  constructor(type: string, id: string) {
    this.answer = "";
    this.type = type;
    this.id = id;
  }

  /**
   * Sets the text answer of an answer object. If the answer is a textbox, the text will be set to the input.
   * Otherwise, the text will be added to the answer ArrayList.
   * @param input: Text of answer to input
   */
  setAnswer(input: string): void {
    if (typeof this.answer === "string") {
      this.answer = input;
    } else {
      try {
        assert(Array.isArray(this.answer));
        this.answer.push(input);
      } catch (e) {
        throw new Error();
      }
    }
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

function createAnswerArray(questions: Question[]): Answer[] {
  const answerList: Answer[] = new Array(questions.length);
  for (let i = 0; i < answerList.length; ++i) {
    answerList[i] = new Answer(
      questions[i].type,
      hashCode(questions[i].question + questions[i].type)
    );
  }
  return answerList;
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
    throw new Error();
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
    throw new Error();
  }
}

export { createPreSessionNotes, createPostSessionNotes, Answer };