/**
 * This file contains the class of errors pertaining
 * to validation errors
 */

import { CustomError } from "./errors";

/**
 * This class is used to contain any error messages pertaining
 * to validating inputs.
 */
const INVALID_EMAIL_ID = "Invalid email was found, email must not have @iusd.org.";
const EMAIL_ALREADY_IN_USE = "E-mail already in use. Please use a different email";
const INVALID_USER_ID = "Invalid user ID, cannot find user.";
const INVALID_PASSWORD_LENGTH =
  "Password must be at least 8 characters long. Please try a different password";

export class ValidationError extends CustomError {
  static INVALID_EMAIL_ID = new ValidationError(0, 400, INVALID_EMAIL_ID);

  static USED_EMAIL = new ValidationError(1, 400, EMAIL_ALREADY_IN_USE);

  static INVALID_USER_ID = new ValidationError(2, 400, INVALID_USER_ID);

  static INVALID_PASSWORD_LENGTH = new ValidationError(3, 400, INVALID_PASSWORD_LENGTH);
}
