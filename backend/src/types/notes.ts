import { Infer } from "caketype";
import { UpdateNoteDetailsCake } from "./cakes";

export type QuestionType = {
  question: string;
  type: string;
};

export type AnswerType = {
  answer: string | Array<string>;
  type: string;
  id: string;
};

export type UpdateNoteDetailsType = Infer<typeof UpdateNoteDetailsCake>;
