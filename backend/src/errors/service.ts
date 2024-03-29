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
const MENTEE_WAS_NOT_SAVED = "Mentee was not saved";
const MENTOR_WAS_NOT_FOUND = "Mentor was not found";
const MENTOR_WAS_NOT_SAVED = "Mentor was not saved";
const IMAGE_WAS_NOT_FOUND = "Image was not found";
const SESSION_WAS_NOT_FOUND = "Session was not found";
const NOTE_WAS_NOT_FOUND = "Note was not found";
const NOTE_WAS_NOT_SAVED = "Note was not saved";
const INVALID_URI = "Calendly URI is invalid. Check formatting of URI string";
const ERROR_GETTING_EVENT_DATA = "There was an error retrieving the calendly event data";

const ERROR_DELETING_EVENT = "There was an error deleting a calendly event";
const INVALID_ROLE_WAS_FOUND = "Allowed user roles for this context is mentor and mentee only";

const ERROR_SENDING_NOTIFICATION = "There was an error sending the notification.";

export class ServiceError extends CustomError {
  static IMAGE_NOT_SAVED = new ServiceError(0, 404, IMAGE_NOT_SAVED);

  static IMAGE_NOT_FOUND = new ServiceError(1, 404, IMAGE_NOT_FOUND);

  static INVALID_MONGO_ID = new ServiceError(2, 404, INVALID_MONGO_ID);

  static MENTEE_WAS_NOT_FOUND = new ServiceError(3, 404, MENTEE_WAS_NOT_FOUND);

  static MENTOR_WAS_NOT_FOUND = new ServiceError(4, 404, MENTOR_WAS_NOT_FOUND);

  static IMAGE_WAS_NOT_FOUND = new ServiceError(5, 404, IMAGE_WAS_NOT_FOUND);

  static INVALID_URI = new ServiceError(6, 404, INVALID_URI);

  static ERROR_GETTING_EVENT_DATA = new ServiceError(7, 404, ERROR_GETTING_EVENT_DATA);

  static SESSION_WAS_NOT_FOUND = new ServiceError(8, 404, SESSION_WAS_NOT_FOUND);

  static NOTE_WAS_NOT_FOUND = new ServiceError(9, 404, NOTE_WAS_NOT_FOUND);

  static NOTE_WAS_NOT_SAVED = new ServiceError(10, 404, NOTE_WAS_NOT_SAVED);

  static MENTOR_WAS_NOT_SAVED = new ServiceError(11, 404, MENTOR_WAS_NOT_SAVED);

  static MENTEE_WAS_NOT_SAVED = new ServiceError(12, 404, MENTEE_WAS_NOT_SAVED);

  static INVALID_ROLE_WAS_FOUND = new ServiceError(13, 404, INVALID_ROLE_WAS_FOUND);

  static ERROR_DELETING_EVENT = new ServiceError(14, 404, ERROR_DELETING_EVENT);

  static ERROR_SENDING_NOTIFICATION = new ServiceError(15, 404, ERROR_SENDING_NOTIFICATION);
}
