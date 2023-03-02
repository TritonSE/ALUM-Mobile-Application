import express from "express";
import mongoose from "mongoose";
import { json } from "body-parser";
import { userRouter } from "./routes/user";
<<<<<<< HEAD
import { sessionsRouter } from "./routes/sessions";
=======
>>>>>>> main
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

server.app.use(json());
server.app.use(userRouter);
server.app.use(sessionsRouter);

// make server listen on some port
server.app.listen(port, () => console.log(`> Listening on port ${port}`)); // eslint-disable-line no-console
