import { assert } from "console";
import preSessionQuestions from "../models/preQuestionsList.json";
import postSessionQuestions from "../models/postQuestionsList.json";
import { Note } from "../models/notes";

/*
 * Class definition for an Answer to a question, can either be textbox or bullet boxes.
 */
class Answer {
  answer: string | Array<string>;

  type: string;

  id: number; // hashed from question

  constructor(type: string, id: number) {
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
      assert(Array.isArray(this.answer));
      this.answer.push(input);
    }
  }
}

/**
 * Function for hashing questions to link them to their answer.
 * @param str: Question+type of question to be hashed
 * @returns: Hash value of the question+type
 */
function hashCode(str: string) {
  let hash = 0;
  for (let i = 0, len = str.length; i < len; i++) {
    const chr = str.charCodeAt(i);
    hash = (hash << 5) - hash + chr;
    hash |= 0; // Convert to 32bit integer
  }
  return hash;
}

/**
 * Create an array of Answer objects from the pre-session question .json.
 * @returns: List of Answer objects with empty answer fields. Each answer has an id that links it to
 * its question.
 */
function createPreAnswerArray() {
  const preAnswerList: Answer[] = new Array(preSessionQuestions.length);
  for (let i = 0; i < preAnswerList.length; ++i) {
    preSessionQuestions[i].id = hashCode(
      preSessionQuestions[i].question + preSessionQuestions[i].type
    );
    preAnswerList[i] = new Answer(preSessionQuestions[i].type, preSessionQuestions[i].id);
  }
  return preAnswerList;
}

/**
 * Create an array of Answer objects from the post-session question .json.
 * @returns: List of Answer objects with empty answer fields. Each answer has an id that links it to
 * its question.
 */
function createPostAnswerArray() {
  const postAnswerList: Answer[] = new Array(postSessionQuestions.length);
  for (let i = 0; i < postAnswerList.length; ++i) {
    postSessionQuestions[i].id = hashCode(
      postSessionQuestions[i].question + postSessionQuestions[i].type
    );
    postAnswerList[i] = new Answer(postSessionQuestions[i].type, postSessionQuestions[i].id);
  }
  return postAnswerList;
}

/**
 * Stores pre-session answers document in MongoDB
 */
async function createPreSessionNotes() {
  let preNotes = null;
  try {
    const preSessionAnswers = createPreAnswerArray();
    preNotes = new Note({ preSessionAnswers, type: "pre" });
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
    const postSessionAnswers = createPostAnswerArray();
    postNotes = new Note({ postSessionAnswers, type: "post" });
    return await postNotes.save();
  } catch (e) {
    throw new Error();
  }
}

export { createPreSessionNotes, createPostSessionNotes, Answer };
