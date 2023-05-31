import dotenv from "dotenv";

dotenv.config({
    path: ".env",
  });

  let serviceAccountKeyV = "";

  if (!process.env.SERVICE_ACCOUNT_KEY) {
    throw new Error();
  } else {
    serviceAccountKeyV = process.env.SERVICE_ACCOUNT_KEY;
  }

  const serviceAccountKey = serviceAccountKeyV;

  export {serviceAccountKey}