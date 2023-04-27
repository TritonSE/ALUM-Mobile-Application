/**
 * This file configures all the enviornment variables
 * to be used throughout the src code
 */

import dotenv from "dotenv";
import { InternalError } from "./errors/internal";

// load the environment variables from the .env file
dotenv.config({
  path: ".env",
});

let portV = "";
let mongoURIV = "";
let serviceAccountKeyV = "";
let defaultImageIdV = "";

/**
 * Todo: these should throw errors instead of logging messages
 */
if (!process.env.APP_PORT) {
  throw InternalError.NO_APP_PORT;
} else {
  portV = process.env.APP_PORT;
}

if (!process.env.MONGO_URI) {
  throw InternalError.NO_MONGO_URI;
} else {
  mongoURIV = process.env.MONGO_URI;
}

if (!process.env.SERVICE_ACCOUNT_KEY) {
  throw InternalError.NO_SERVICE_ACCOUNT_KEY;
} else {
  serviceAccountKeyV = process.env.SERVICE_ACCOUNT_KEY;
}

if (!process.env.DEFAULT_IMAGE_ID) {
  throw InternalError.NO_DEFAULT_IMAGE_ID;
} else {
  defaultImageIdV = process.env.DEFAULT_IMAGE_ID;
}

/**
 * Have to do this workaround since lint doesn't let
 * us export vars
 */
const port = portV;
const mongoURI = mongoURIV;
const serviceAccountKey = serviceAccountKeyV;
const defaultImageID = defaultImageIdV;
const accessToken = process.env.CALENDLY_TOKEN;

export { port, mongoURI, serviceAccountKey, defaultImageID, accessToken };
