import { Infer } from "caketype";
import { CreateMenteeRequestBodyCake, CreateMentorRequestBodyCake } from "./cakes";

export type UserStatusType = "paired" | "under review" | "approved";
export type CreateMenteeRequestBodyType = Infer<typeof CreateMenteeRequestBodyCake>;
export type CreateMentorRequestBodyType = Infer<typeof CreateMentorRequestBodyCake>;
