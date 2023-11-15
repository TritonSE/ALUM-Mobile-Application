'use client'

import React, {useEffect, useState} from 'react';
import * as firebase from 'firebase/compat/app';
import { getAuth, onAuthStateChanged, signInWithEmailAndPassword   } from "firebase/auth";
import signIn from "../../../firebase/signin";
import { getToken } from '@/firebase/token';
import app from "@/firebase/config";
import '../../../styles/Sessions.module.css';
import { ObjectId } from 'mongoose';

type GetSessionData = {
  message: string;
  session: GetSession[];
}

type GetSession = {
  id: ObjectId | string;
  day: string;
  menteeId: ObjectId | string;
  mentorId: ObjectId | string;
  missed: boolean;
  missedSessionReason: string;
  hasPassed: boolean;
  fullDateString: string;
  dateShortHandString: string;
  startTimeString: string;
  endTimeString: string;
}

async function getSessionData(authKey: string) {
  let url = "http://localhost:3000/allSessions";
  const headers = {
    Authorization: `Bearer ${authKey}`,
  };
  const res = await fetch(url, {headers});
  const data: GetSessionData = await res.json();
  return data
}


async function getSessionDataWithAuth() {
  return new Promise<GetSessionData>((resolve, reject) => {
    const auth = getAuth(app);
    signInWithEmailAndPassword(auth, "admin@gmail.com", "12345678#");
    onAuthStateChanged(auth, (user) => {
      if (user) {
        user.getIdToken().then(
          async (token) => {
            try {
              console.log("token: ", token);
              const data = await getSessionData(token);
              resolve(data);
            } catch (e) {
              console.log(e);
              reject(e);
            }
          }
        );
      }
    });
  });
}


export default async function SessionsPage() {
  let url = "http://localhost:3000/allSessions";
  // let data = null
  const [data, setData] = useState<GetSessionData>();
  let sessions;
  const auth = getAuth(app);
  signInWithEmailAndPassword(auth, "admin@gmail.com", "12345678#");
  
  var dataNew: GetSessionData = {
    message: "default message",
    session: [
      {
        id: "null",
        day: "day",
        menteeId: "mentee",
        mentorId: "mentor",
        missed: true,
        missedSessionReason: "missed",
        hasPassed: true,
        fullDateString: "full date",
        dateShortHandString: "date short hand",
        startTimeString: "start time",
        endTimeString: "end time"
      }
    ]
  };
  
  onAuthStateChanged(auth, (user) => {
    if (user) {
      user.getIdToken().then(
        async (token) => {
          try {
            const headers = {
              Authorization: `Bearer ${token}`,
            };
            fetch(url, {headers}).then(
              res => res.json()
            ).then(
              dataToSet => {
                // data = dataToSet;
                setData(dataToSet);
                dataNew = dataToSet;
                console.log(data);
              }
            )
          } catch(e) {
            console.log("Error in using token: " + e);
          }
        }
      )
    }
  }) 

  /*
  const [data, setData] = useState<GetSessionData>();
  await getSessionDataWithAuth().then(
      (res: GetSessionData) => setData(res)
    ).catch(
      (error) => console.error(error)
    );
  */
  return (
    <>
      <main>
        <div>
          <h1> 'This is the sessions page!' </h1>
          {(typeof data === 'undefined') ? (
            <div>
              <p>Data is loading...</p>
            </div>
          ) : (
            <div>
              <p>Data has loaded!</p>
              <p>Message: {data.message}</p>
            </div>
          )}
        </div>
      </main>
    </>
  );
}


// SessionsPage.tsx
/*
export default async function SessionsPage() {
  const auth = getAuth();
  const [data, setData] = useState<any>();
  
  useEffect(() => {
    signInWithEmailAndPassword(auth, 'admin@gmail.com', '12345678#')
      .then(() => {
        onAuthStateChanged(auth, (user) => {
          if (user) {
            user.getIdToken().then(async (token) => {
              fetchSessions(token);
            });
          }
        });
      })
      .catch((error) => {
        console.error('Error signing in:', error);
      });
  }, [auth]);

  const fetchSessions = (token: string) => {
    const url = 'http://localhost:3000/allSessions';
    const headers = { Authorization: `Bearer ${token}` };

    fetch(url, { headers })
      .then((res) => res.json())
      .then((dataToSet) => {
        setData(dataToSet);
      })
      .catch((error) => {
        console.error('Error fetching sessions:', error);
      });
  };

  return (
    <>
      <main>
        <div>
          <h1> 'This is the sessions page!' </h1>
          {(typeof data === 'undefined') ? (
            <div>
              <p>Data is loading...</p>
            </div>
          ) : (
            <div>
              <p>Data has loaded!</p>
              <p>Message: {data.message}</p>
            </div>
          )}
        </div>
      </main>
    </>
  );
};
*/

/*
export default function SessionsPage() {
  let url = "http://localhost:3000/allSessions";
  const [data, setData] = useState<GetSessionData>();
  const auth = getAuth(app);

  // Move signInWithEmailAndPassword outside of onAuthStateChanged
  signInWithEmailAndPassword(auth, "admin@gmail.com", "12345678#").then(
    async (userCredential) => {
      // User successfully signed in
      const token = await userCredential.user.getIdToken();
      const headers = {
        Authorization: `Bearer ${token}`,
      };

      fetch(url, { headers }).then(
        res => res.json()
      ).then(
        dataToSet => {
          setData(dataToSet);
          console.log(data);
        }
      );
    },
    (error) => {
      console.error("Error signing in:", error);
    }
  );

  return (
    <>
      <main>
        <div>
          <h1> 'This is the sessions page!' </h1>
          {(typeof data === 'undefined') ? (
            <div>
              <p>Data is loading...</p>
            </div>
          ) : (
            <div>
              <p>Data has loaded!</p>
              <p>Message: {data.message}</p>
            </div>
          )}
        </div>
      </main>
    </>
  );
}
*/