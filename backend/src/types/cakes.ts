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

/**
 * POST /mentor
 */
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
  personalAccessToken: string,
  location: string,
  calendlyLink: string,
});

// PATCH user/id
export const UpdateUserCake = bake({
  fcmToken: string,
  uid: string,
  role: string,
});
export const UpdateMentorRequestBodyCake = bake({
  name: string,
  about: string,
  graduationYear: number,
  college: string,
  major: string,
  imageId: string,
  minor: string,
  career: string,
  personalAccessToken: string,
  topicsOfExpertise: array(string),
  mentorMotivation: string,
  location: string,
  calendlyLink: string,
  zoomLink: string,
});

// PATCH user/id
export const UpdateMenteeRequestBodyCake = bake({
  name: string,
  grade: number,
  about: string,
  imageId: string,
  topicsOfInterest: array(string),
  careerInterests: array(string),
  mentorshipGoal: string,
});

// PATCH notes/id
export const UpdateNoteDetailsCake = bake({
  answer: union(string, array(string)),
  type: string,
  questionId: string,
});
export const UpdateNoteRequestBodyCake = array(UpdateNoteDetailsCake);

// POST sessions
export const CreateSessionRequestBodyCake = bake({
  calendlyURI: string,
});
