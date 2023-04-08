import { bake, string, array, union } from "caketype";

// PATCH notes/id
export const UpdateNoteDetailsCake = bake({
  answer: union(string, array(string)),
  type: string,
  question_id: string,
});
export const UpdateNoteRequestBodyCake = array(UpdateNoteDetailsCake);

// POST sessions
export const CreateSessionRequestBodyCake = bake({
  menteeId: string,
  mentorId: string,
  dateInfo: string,
});
