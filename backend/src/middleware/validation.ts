/**
 * This file is used to store functions the validate requests
 * for the various routes. The type checking is done using
 * Justin's caketype library (see github for specifications).
 * https://github.com/justinyaodu/caketype
 * All error messages are stored in the errors.ts file.
 *
 *
 * All requests must have a function to validate the requests.
 * Moreover, be sure to add cake types of each type of request you
 * are validating (look below for examples).
 */

import { Cake } from "caketype";
import { Request, Response, NextFunction } from "express";
import { ValidationError } from "../errors";

/**
 * This is a high-order function which returns a function that can be
 * used as a middleware to enforce that a request follows cake type
 * @param cake
 * @returns
 * Returns a 400 response with the error message if any error is found.
 * Otherwise, passes control to the next function in line
 */
const validateReqBodyWithCake =
  (cake: Cake) => async (req: Request, res: Response, next: NextFunction) => {
    console.log("req body - ", req.body);
    const result = cake.check(req.body);
    if (!result.ok) {
      return next(new ValidationError(4, 400, result.error.toString()));
    }
    return next();
  };

export { validateReqBodyWithCake };
