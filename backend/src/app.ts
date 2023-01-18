import dotenv from "dotenv";
import express from "express";
import mongoose from 'mongoose';

// load the environment variables from the .env file
dotenv.config({
  path: ".env",
});

/**
 * Express server application class.
 * @description Will later contain the routing system.
 */
class Server {
  public app = express();
}

// initialize server app
const server = new Server();

if(process.env.MONGO_URI) {
  mongoose.connect(process.env.MONGO_URI, {
    
  }, () => {
    console.log("Connected to Database");
  })
}


// make server listen on some port
((port = process.env.APP_PORT || 3000) => {
  server.app.listen(port, () => console.log(`> Listening on port ${port}`)); // eslint-disable-line no-console
})();
