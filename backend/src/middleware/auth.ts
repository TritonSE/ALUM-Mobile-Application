/**
 * This file contains middleware functions to help with authentication
 * of a user
 *
 */

import { Request, Response, NextFunction } from "express";
import { decodeAuth } from "../services/firebase/auth";
import { AuthError } from "../errors/authError";

/**
 * This function ensures that a valid auth token is passed through
 * the request header
 *
 * Allow either a User or Admin to access the route
 * @param req: Request (should contain token in header)
 * @param res: Response
 * @param next: Next function
 */
const validateAuthToken = async (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;
  const token =
    authHeader && authHeader.split(" ")[0] === "Bearer" ? authHeader?.split(" ")[1] : null;
  if (!token) {
    return res
      .status(AuthError.TOKEN_NOT_FOUND.status)
      .send(AuthError.TOKEN_NOT_FOUND.displayMessage(false));
  }

  const decodedToken = await decodeAuth(token);

  if (decodedToken) {
    return next();
  }

  return res
    .status(AuthError.UNAUTHORIZED_USER.status)
    .send(AuthError.UNAUTHORIZED_USER.displayMessage(true));
};

export { validateAuthToken };
