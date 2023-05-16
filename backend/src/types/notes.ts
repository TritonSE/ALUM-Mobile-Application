import { Infer } from "caketype";
import { UpdateNoteDetailsCake } from "./cakes";

export type QuestionType = {
  question: string;
  type: string;
};

export type AnswerType = {
  answer: string | Array<string> | Array<CheckboxBulletItem>;
  type: string;
  id: string;
};

export type CheckboxBulletItem = {
  content: string;
  status: string; // checked, unchecked, bullet
};

export type UpdateNoteDetailsType = Infer<typeof UpdateNoteDetailsCake>;
