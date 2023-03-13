/**
 * This file contains errors pertaining to errors in service
 * functions
 */

import { CustomError } from "./errors";

const IMAGE_NOT_SAVED =
  "Image was not able to be saved. Be sure to specify that image key is image";
const IMAGE_NOT_FOUND = "Image was not found. Please make sure id passed in route is valid";
const INVALID_MONGO_ID = "Mongo Id was invalid. Please ensure that the id is correct";
const MENTEE_WAS_NOT_FOUND = "Mentee was not found";
const MENTOR_WAS_NOT_FOUND = "Menor was not found";
const IMAGE_WAS_NOT_FOUND = "Image was not found";

export class ServiceError extends CustomError {
  static IMAGE_NOT_SAVED = new ServiceError(0, 402, IMAGE_NOT_SAVED);

  static IMAGE_NOT_FOUND = new ServiceError(1, 402, IMAGE_NOT_FOUND);

  static INVALID_MONGO_ID = new ServiceError(2, 402, INVALID_MONGO_ID);

  static MENTEE_WAS_NOT_FOUND = new ServiceError(3, 402, MENTEE_WAS_NOT_FOUND);

  static MENTOR_WAS_NOT_FOUND = new ServiceError(4, 402, MENTOR_WAS_NOT_FOUND);

  static IMAGE_WAS_NOT_FOUND = new ServiceError(5, 402, IMAGE_WAS_NOT_FOUND);
}
