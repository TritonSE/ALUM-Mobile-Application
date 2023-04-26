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
const SESSION_WAS_NOT_FOUND = "Session was not found";
const NOTE_WAS_NOT_FOUND = "Note was not found";

export class ServiceError extends CustomError {
  static IMAGE_NOT_SAVED = new ServiceError(0, 404, IMAGE_NOT_SAVED);

  static IMAGE_NOT_FOUND = new ServiceError(1, 404, IMAGE_NOT_FOUND);

  static INVALID_MONGO_ID = new ServiceError(2, 404, INVALID_MONGO_ID);

  static MENTEE_WAS_NOT_FOUND = new ServiceError(3, 404, MENTEE_WAS_NOT_FOUND);

  static MENTOR_WAS_NOT_FOUND = new ServiceError(4, 404, MENTOR_WAS_NOT_FOUND);

  static IMAGE_WAS_NOT_FOUND = new ServiceError(5, 404, IMAGE_WAS_NOT_FOUND);

  static SESSION_WAS_NOT_FOUND = new ServiceError(6, 404, SESSION_WAS_NOT_FOUND);

  static NOTE_WAS_NOT_FOUND = new ServiceError(7, 404, NOTE_WAS_NOT_FOUND);
}
