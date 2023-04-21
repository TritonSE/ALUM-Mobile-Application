/**
 * This file contains functions to verify auth tokens and
 * a user roles
 */

import { Request, Response, NextFunction } from "express";
import { decodeAuthToken } from "../services/auth";
import { CustomError } from "../errors";
import { AuthError } from "../errors/auth";

/**
 * Middleware to verify Auth token and calls next function based on user role
 */
const verifyAuthToken = async (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;
  const token =
    authHeader && authHeader.split(" ")[0] === "Bearer" ? authHeader.split(" ")[1] : null;
  if (!token) {
    return res.status(AuthError.TOKEN_NOT_IN_HEADER.status).send(AuthError.TOKEN_NOT_IN_HEADER.displayMessage(true));
  }

  let userInfo;
  try {
    userInfo = await decodeAuthToken(token);
  } catch (e) {
    if (e instanceof CustomError) {
      return res.status(e.status).send(e.displayMessage(false));
    }
  }

  if (userInfo) {
    req.body.uid = userInfo.user_id;
    req.body.role = userInfo.role;
    return next();
  }

  return res.status(AuthError.INVALID_AUTH_TOKEN.status).send(AuthError.INVALID_AUTH_TOKEN.message);
};

export { verifyAuthToken };
