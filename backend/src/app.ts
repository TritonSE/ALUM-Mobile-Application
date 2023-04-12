import express from "express";
import mongoose from "mongoose";
import { json } from "body-parser";
import { userRouter } from "./routes/user";
import { notesRouter } from "./routes/notes";
import { sessionsRouter } from "./routes/sessions";
import { mongoURI, port } from "./config";
import { fillHashMap } from "./services/note";
import preSessionQuestions from "./models/preQuestionsList.json";
import postSessionQuestions from "./models/postQuestionsList.json";


/**
 * Express server application class.
 * @description Will later contain the routing system.
 */
class Server {
  public app = express();
  public questionIDs = new Map<string, string>();
  constructor(){
    fillHashMap(preSessionQuestions, this.questionIDs);
    fillHashMap(postSessionQuestions, this.questionIDs);
  }
}

// initialize server app
const server = new Server();

mongoose.connect(mongoURI, {}, () => {
  console.log("Connected to Database.");
});

server.app.use(json());
server.app.use(userRouter);
server.app.use(sessionsRouter);
server.app.use(notesRouter);

// make server listen on some port
server.app.listen(port, () => console.log(`> Listening on port ${port}`)); // eslint-disable-line no-console

export const questionIDs = server.questionIDs;
