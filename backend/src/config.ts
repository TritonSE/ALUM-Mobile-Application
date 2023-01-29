/**
 * This file configures all the enviornment variables 
 * to be used throughout the src code
 */

import dotenv from "dotenv";

// load the environment variables from the .env file
dotenv.config({
    path: ".env",
});

var port: string;
var mongoURI: string;
var serviceAccountKey: string;


if(!process.env.APP_PORT) {
    console.log("Could not find app port env variable");
} else {
    port = process.env.APP_PORT;
}

if(!process.env.MONGO_URI) {
    console.log("Could not find mongo uri env variable");
} else {
    mongoURI = process.env.MONGO_URI;
}

if(!process.env.SERVICE_ACCOUNT_KEY) {
    console.log("Could not find service account key env variable");
} else {
    serviceAccountKey = process.env.SERVICE_ACCOUNT_KEY;
}

export { port, mongoURI, serviceAccountKey }

