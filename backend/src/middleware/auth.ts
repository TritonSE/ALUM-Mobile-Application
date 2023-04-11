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
  try {
    const authHeader = req.headers.authorization;
    const token =
      authHeader && authHeader.split(" ")[0] === "Bearer" ? authHeader.split(" ")[1] : null;
    if (!token) {
      throw AuthError.TOKEN_NOT_IN_HEADER;
    }

    const userInfo = await decodeAuthToken(token);

    if (userInfo) {
      req.body.role = userInfo.role;
      return next();
    }
    throw AuthError.INVALID_AUTH_TOKEN;
  } catch (e) {
    return next(e);
  }
};

export { verifyAuthToken };
