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
const EMAIL_ALREADY_IN_USE = "E-mail already in use!";
const INVALID_USER_ID = "Invalid user ID, cannot find user.";
const INVALID_PASSWORD_LENGTH = "Password must be at least 8 characters long";
const INVALID_CALENDLY_LINK = "Invalid Calendly link found. Please retry";

export class ValidationError extends CustomError {
  static INVALID_EMAIL_ID = new ValidationError(0, 400, INVALID_EMAIL_ID);

  static USED_EMAIL = new ValidationError(1, 400, EMAIL_ALREADY_IN_USE);

  static INVALID_USER_ID = new ValidationError(2, 400, INVALID_USER_ID);

  static INVALID_PASSWORD_LENGTH = new ValidationError(3, 400, INVALID_PASSWORD_LENGTH);

  static INVALID_CALENDLY_PERSONAL_ACCESS_TOKEN = new ValidationError(4, 400, "Invalid Calendly Access Token found. Please retry");

  static INVALID_CALENDLY_LINK = new ValidationError(5, 400, INVALID_CALENDLY_LINK);
}
