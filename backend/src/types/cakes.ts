/**
 * This file can be used as a reference to see what are the arguments accepted by each route.
 * Cakes for all route requests are created. Just look for a comment for the route you are looking for
 */
import { bake, string, array, number, union } from "caketype";

/**
 * POST /mentee
 */
export const CreateMenteeRequestBodyCake = bake({
  name: string,
  email: string,
  password: string,
  grade: number,
  topicsOfInterest: array(string),
  careerInterests: array(string),
  mentorshipGoal: string,
});

export const CreateMentorRequestBodyCake = bake({
  name: string,
  email: string,
  password: string,
  graduationYear: number,
  college: string,
  major: string,
  minor: string,
  career: string,
  topicsOfExpertise: array(string),
  mentorMotivation: string,
  location: string,
});

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
