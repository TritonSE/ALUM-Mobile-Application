/**
 * This class pertains to any internal errors that may not occur
 */

import { CustomError } from "./errors";

const ERROR_GETTING_MENTEE = "There was some error getting the mentee";
const ERROR_GETTING_MENTOR = "There was some error getting the mentor";
const ERROR_GETTING_IMAGE = "There was some error getting the image";
const NO_APP_PORT = "Could not find app port env variable";
const NO_MONGO_URI = "Could not find mongo uri env variable";
const NO_SERVICE_ACCOUNT_KEY = "Could not find service account key env variable";
const NO_DEFAULT_IMAGE_ID = "Could not find default image id env variable";

export class InternalError extends CustomError {
  static ERROR_GETTING_MENTEE = new InternalError(0, 403, ERROR_GETTING_MENTEE);

  static ERROR_GETTING_MENTOR = new InternalError(1, 403, ERROR_GETTING_MENTOR);

  static ERROR_GETTING_IMAGE = new InternalError(2, 403, ERROR_GETTING_IMAGE);

  static NO_APP_PORT = new InternalError(3, 403, NO_APP_PORT);

  static NO_MONGO_URI = new InternalError(4, 403, NO_MONGO_URI);

  static NO_SERVICE_ACCOUNT_KEY = new InternalError(5, 403, NO_SERVICE_ACCOUNT_KEY);

  static NO_DEFAULT_IMAGE_ID = new InternalError(6, 403, NO_DEFAULT_IMAGE_ID);
}