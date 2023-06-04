import { Infer } from "caketype";
import {
  CreateMenteeRequestBodyCake,
  CreateMentorRequestBodyCake,
  UpdateMenteeRequestBodyCake,
  UpdateMentorRequestBodyCake,
} from "./cakes";

export type UpdateMenteeRequestBodyType = Infer<typeof UpdateMenteeRequestBodyCake>;
export type UpdateMentorRequestBodyType = Infer<typeof UpdateMentorRequestBodyCake>;
export type CreateMenteeRequestBodyType = Infer<typeof CreateMenteeRequestBodyCake>;
export type CreateMentorRequestBodyType = Infer<typeof CreateMentorRequestBodyCake>;
