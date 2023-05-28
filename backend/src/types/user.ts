import { Infer } from "caketype";
import { CreateMenteeRequestBodyCake, CreateMentorRequestBodyCake, UpdateMenteeRequestBodyCake, UpdateMentorRequestBodyCake } from "./cakes";

export type UpdateMenteeRequestBodyCake = Infer<typeof UpdateMenteeRequestBodyCake>;
export type UpdateMentorRequestBodyCake = Infer<typeof UpdateMentorRequestBodyCake>;
export type CreateMenteeRequestBodyType = Infer<typeof CreateMenteeRequestBodyCake>;
export type CreateMentorRequestBodyType = Infer<typeof CreateMentorRequestBodyCake>;
