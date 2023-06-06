import dotenv from "dotenv";

dotenv.config({
    path: ".env",
  });

console.log(process.env.SERVICE_ACCOUNT_KEY);
const serviceAccountKey = process.env.SERVICE_ACCOUNTKEY;

export {serviceAccountKey}