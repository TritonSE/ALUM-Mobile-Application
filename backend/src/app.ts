import express from "express";
import mongoose from "mongoose";
import { json } from "body-parser";

import { userRouter } from "./routes/user";
import { notesRouter } from "./routes/notes";
import { sessionsRouter } from "./routes/sessions";
import { mongoURI, port } from "./config";
import { imageRouter } from "./routes/image";
import { errorHandler } from "./errors/handler";
import { Pairing } from "./models/pairing";


import { calendlyPage } from "./routes/calendlyPage";
/**
 * Express server application class.
 * @description Will later contain the routing system.
 */
class Server {
  public app = express();
}

// initialize server app
const server = new Server();

mongoose.connect(mongoURI, {}, () => {
  console.log("Connected to Database.");
});

const pairing = new Pairing({
  menteeId: "6431b99ebcf4420fe9825fe3",
  mentorId: "6431b9a2bcf4420fe9825fe5",
  whyPaired: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
});

pairing.save();

server.app.use(json());
server.app.set('view engine', 'pug')
server.app.use(userRouter);
server.app.use(sessionsRouter);
server.app.use(notesRouter);
server.app.use(imageRouter);
server.app.use(calendlyPage);
server.app.use(errorHandler); // This handler is reached whenever there is some error in our middleware chain

// make server listen on some port
server.app.listen(port, () => console.log(`> Listening on port ${port}`)); // eslint-disable-line no-console
