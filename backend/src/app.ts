import express, { Request, Response } from "express";
import mongoose from "mongoose";
import { json } from "body-parser";
import { userRouter } from "./routes/user";
import { sessionsRouter } from "./routes/sessions";
import { mongoURI, port } from "./config";
import { ValidationError, CustomError } from "./errors/index";

/**
 * Generic Error Handler
 */
const errorHandler = (err: CustomError, _req: Request, res: Response) => {
  if (!err) return;
  if (err instanceof ValidationError) {
    console.log(err.displayMessage(true));
    res.status(err.status).send(err.displayMessage(true));
    return;
  }
  console.log("Unknown Error. Try again", err);
  res.status(500).send("Unknown Error. Try again");
};

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
server.app.use(errorHandler);

// make server listen on some port
server.app.listen(port, () => console.log(`> Listening on port ${port}`)); // eslint-disable-line no-console
