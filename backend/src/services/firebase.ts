/**
 * This file contains the configuration for firebase
 * It exports a firebase auth object which will allow users
 * to access any firebase services. For this project we will use
 * firebase to for authentication.
 */

import * as firebase from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import dotenv from "dotenv";

dotenv.config({
    path: ".env",
});

var serviceAccountKey = '';

if(process.env.SERVICE_ACCOUNT_KEY) {
    serviceAccountKey = process.env.SERVICE_ACCOUNT_KEY; 
} else {
    console.log('Service Account Key is not found')
}

//Initalize firebase app
firebase.initializeApp({
        credential: firebase.cert(JSON.parse(serviceAccountKey))
})

const firebaseAuth = getAuth();

export { firebaseAuth }


