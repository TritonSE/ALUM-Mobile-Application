/**
 * This file contains the class of errors pertaining
 * to validation errors
 */

import { Error } from "./errors";

/**
 * This class is used to contain any error messages pertaining
 * to validating inputs.
 */
const INVALID_EMAIL_ID = "Invalid email was found, email must not have @iusd.org.";
const TYPE_NOT_FOUND = "Type of user was not found or was incorrect, please specify the user type.";
const EMAIL_ALREADY_IN_USE = "E-mail already in use!";
const INVALID_USER_ID = "Invalid user ID, cannot find user.";

export class ValidationError extends Error {
  static INVALID_EMAIL_ID = new ValidationError(0, 400, INVALID_EMAIL_ID);

  static TYPE_NOT_FOUND = new ValidationError(1, 400, TYPE_NOT_FOUND);

  static USED_EMAIL = new ValidationError(2, 400, EMAIL_ALREADY_IN_USE);

  static INVALID_USER_ID = new ValidationError(3, 400, INVALID_USER_ID);
}
