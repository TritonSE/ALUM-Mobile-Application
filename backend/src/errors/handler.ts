/**
 * Generic Error Handler
 */
import { Request, Response, NextFunction } from "express";
import { CustomError } from "./errors";
import { InternalError } from "./internal";

// eslint-disable-next-line @typescript-eslint/no-unused-vars
export const errorHandler = (err: Error, _req: Request, res: Response, _next: NextFunction) => {
  if (!err) return;
  console.log("error detected");
  if (err instanceof CustomError && !(err instanceof InternalError)) {
    console.log(err.displayMessage(true));
    res.status(err.status).send(err.displayMessage(true));
    return;
  }

  console.log("Unknown Error. Try again", err);
  res.status(500).send("Unknown Error. Try again");
};
