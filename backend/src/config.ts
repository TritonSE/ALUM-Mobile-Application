/**
 * This file configures all the enviornment variables
 * to be used throughout the src code
 */

import dotenv from "dotenv";

// load the environment variables from the .env file
dotenv.config({
  path: "/Users/yashravipati/Documents/GitHub/ALUM-Mobile-Application/backend/env",
});

let portV = "";
let mongoURIV = "";
let serviceAccountKeyV = "";

/**
 * Todo: these should throw errors instead of logging messages
 */
if (!process.env.APP_PORT) {
  console.log("Could not find app port env variable");
} else {
  portV = process.env.APP_PORT;
}

if (!process.env.MONGO_URI) {
  console.log("Could not find mongo uri env variable");
} else {
  mongoURIV = process.env.MONGO_URI;
}

if (!process.env.SERVICE_ACCOUNT_KEY) {
  console.log("Could not find service account key env variable");
} else {
  serviceAccountKeyV = process.env.SERVICE_ACCOUNT_KEY;
}

/**
 * Have to do this workaround since lint doesn't let
 * us export vars
 */
const port = portV;
const mongoURI = mongoURIV;
const serviceAccountKey = serviceAccountKeyV;

export { port, mongoURI, serviceAccountKey };
