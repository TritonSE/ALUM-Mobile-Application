import express from 'express';
import { json } from "body-parser";
import {adminRouter} from './admin'


class Server {
    public app = express();
  }
  
  // initialize server app
  const server = new Server();
  server.app.use(json());
  server.app.use(adminRouter);

  server.app.listen(3000, () => console.log(`> Listening on port 3000`)); 