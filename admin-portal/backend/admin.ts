import express, { NextFunction, Request, Response } from "express";
import * as admin from 'firebase-admin';
import { serviceAccountKey } from './config';

const router = express.Router();

admin.initializeApp({
  credential: admin.credential.cert(JSON.parse(serviceAccountKey)),
  databaseURL: 'https://Alum-Mobile-App.firebaseio.com',
});


  router.post('/admin-users', async (req: Request, res: Response)=> {
    try {
      const { email, password } = req.body;
      const userRecord = await admin.auth().createUser({
        email: email,
        password: password,
        displayName: 'admin',
        disabled: false
      });
  
      res.status(201).json({
        message: `Admin was succesfully created.`,
        userID: userRecord.uid,
      });
    } catch (error) {
      console.error('Error creating new admin user:', error);
      res.status(500).json({ error: 'Error creating new admin user' });
    }
  });
  
  export {router as adminRouter};
