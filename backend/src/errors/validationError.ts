/**
 * This file contains the class of errors pertaining
 * to validation errors
 */

import { Error } from "./errors";

/**
 * This class is used to contain any error messages pertaining
 * to validating inputs. 
 */
const INVALID_EMAIL_ID = 'Invalid email was found, email must not have @iusd.org';
const TYPE_NOT_FOUND = 'Type of user was not found, please specify the user type'

export class ValidationError extends Error {
  
  static INVALID_EMAIL_ID = new ValidationError(0, 400, INVALID_EMAIL_ID);
  
  static TYPE_NOT_FOUND = new ValidationError(1, 400, TYPE_NOT_FOUND);
  
}