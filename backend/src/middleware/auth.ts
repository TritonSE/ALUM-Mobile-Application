/**
 * This file contains functions to verify auth tokens and
 * a user roles
 */

import { decodeAuthToken } from "../services/auth";
import {Request, Response, NextFunction} from "express";

/**
 * Middleware to verify Auth token and calls next function based on user role
 */
const verifyAuthToken = async (req: Request, res: Response, next: NextFunction) => {
    const authHeader = req.headers.authorization;
    console.log(authHeader?.split(" ")[0]);
    let token = authHeader && authHeader.split(" ")[0] === "Bearer" ? authHeader.split(" ")[1] : null;
    if(!token) {
        return res.status(401).send("Please provide auth token in header");
    }

    const userInfo = await decodeAuthToken(token);

    if(userInfo) {
        req.body.role = userInfo.role;
        return next();
    }

    return res.status(401).send("Invalid auth token.");
}

export { verifyAuthToken };