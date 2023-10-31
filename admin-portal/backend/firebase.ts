import { initializeApp } from "firebase/app";

const firebaseConfig = {
  apiKey: "AIzaSyDXhNQM8U0GUoCEG3Qj5tz_GoFStXQ5Mxs",
  authDomain: "alum-mobile-app.firebaseapp.com",
  projectId: "alum-mobile-app",
  storageBucket: "alum-mobile-app.appspot.com",
  messagingSenderId: "41074817131",
  appId: "1:41074817131:web:ee680262ab40d1e4e4592e",
  measurementId: "G-F5667G1HLP"
};
const app = initializeApp(firebaseConfig);

export const initializeFirebase = () => {
    return app;
  }
