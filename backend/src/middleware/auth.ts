/**
 * This file contains functions to verify auth tokens and
 * a user roles
 */

import { Request, Response, NextFunction } from "express";
import { decodeAuthToken } from "../services/auth";
import { AuthError } from "../errors/auth";

/**
 * Middleware to verify Auth token and calls next function based on user role
 */
const verifyAuthToken = async (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;
  console.log(authHeader?.split(" ")[0]);
  const token =
    authHeader && authHeader.split(" ")[0] === "Bearer" ? authHeader.split(" ")[1] : null;
  if (!token) {
    return res
      .status(AuthError.TOKEN_NOT_IN_HEADER.status)
      .send(AuthError.TOKEN_NOT_IN_HEADER.message);
  }

  const userInfo = await decodeAuthToken(token);

  if (userInfo) {
    req.body.role = userInfo.role;
    return next();
  }

  return res.status(AuthError.INVALID_AUTH_TOKEN.status).send(AuthError.INVALID_AUTH_TOKEN.message);
};

export { verifyAuthToken };
