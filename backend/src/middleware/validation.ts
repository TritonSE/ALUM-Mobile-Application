/**
 * This file is used to store functions the validate requests
 * for the various routes. The type checking is done using
 * Justin's caketype library (see github for specifications).
 * All error messages are stored in the errors.ts file.
 * 
 * 
 * All requests must have a function to validate the requests. 
 * Moreover, be sure to add cake types of each type of request you
 * are validating (look below for examples).
 */

import {bake, string } from "caketype";
import { Request, Response, NextFunction } from "express";
import { ValidationError } from "../errors/validationError";

/**
 * mentee cake type to be used to validate mentee
 * NOTE: proper request will follow this format
 */
const MENTEE = bake({
    type: string,
    name: string,
    email: string,
    password: string
})

/**
 * mentor cake type to be used to validate mentor
 * NOTE: proper request will follow this format
 */
const MENTOR = bake({
    type: string,
    name: string,
    email: string,
    password: string,
    organization_id: string,
    personal_access_token: string
})

/**
 * Function to validate whether proper inputs were given
 * in the request when generating mentee.
 * @param req: request
 * @param res: response
 * @param next: next function to be called
 * @returns 
 */
const validateMentee = (req: Request, res: Response, next: NextFunction) => {
    const requestBody = req.body;

    if(requestBody.type !== "Mentee") {
        return res.status(ValidationError.TYPE_NOT_FOUND.status).send(ValidationError.TYPE_NOT_FOUND.displayMessage(true));
    }

    const validateMentee = MENTEE.check(requestBody);

    if(validateMentee.ok){
        return next();
    } 

    return res.status(400).send(validateMentee.error.toString());  

}

/**
 * Function to validate whether proper inputs were given
 * in the request when generating mentor.
 * @param req: request
 * @param res: response
 * @param next: next function to be called
 * @returns 
 */
const validateMentor = (req: Request, res: Response, next: NextFunction) => {
    const requestBody = req.body;

    if(requestBody.type !== "Mentor") {
        return res.status(ValidationError.TYPE_NOT_FOUND.status).send(ValidationError.TYPE_NOT_FOUND.displayMessage(true)); 
    }

    const validateMentor = MENTOR.check(requestBody);
    if(validateMentor.ok) {
        return next();
    }

    return res.status(400).send(validateMentor.error.toString());
}

export { validateMentee, validateMentor }
