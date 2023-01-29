import dotenv from "dotenv";
import express from "express";
import mongoose from "mongoose";
import { json } from "body-parser";
import { userRouter } from "./routes/user";
import { firebaseAuth } from "./services/firebase";
import { createUser } from "./services/auth";
import { mongoURI, port } from "./config";

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


// console.log(firebaseAuth);

// const record = createUser('1234567', 'boogus@gmail.com', 'TseIsCool');

// console.log(record);

server.app.use(json());
server.app.use(userRouter);

// make server listen on some port
server.app.listen(port, () => console.log(`> Listening on port ${port}`)); // eslint-disable-line no-console

