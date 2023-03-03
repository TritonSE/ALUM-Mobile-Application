/**
 * This file contains a class of errors pertaining to authenticating
 * a user
 */

import { CustomError } from "./errors";

/**
 * This class is used to contain error messages pertaining to errors
 * when authenticating a user
 */

const ERROR_DECODING_TOKEN =
  "Error while decoding the auth token, check to make sure auth token is valid";
const TOKEN_NOT_FOUND = "Auth token was not found in auth header. BE SURE TO INCLUDE IT!";
const UNAUTHORIZED_USER = "You are not authorized to make this request.";

export class AuthError extends CustomError {
  static ERROR_DECODING_TOKEN = new AuthError(0, 401, ERROR_DECODING_TOKEN);

  static TOKEN_NOT_FOUND = new AuthError(1, 401, TOKEN_NOT_FOUND);

  static UNAUTHORIZED_USER = new AuthError(2, 401, UNAUTHORIZED_USER);
}
