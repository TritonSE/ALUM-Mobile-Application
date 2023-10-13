"use client";

import React from 'react';
import '../../styles/globals.css'
import Image from 'next/image';
import { initializeFirebase } from '../../../backend/firebase';
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";
import {useAuthState} from 'react-firebase-hooks/auth'
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';

export const app = initializeFirebase();
export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const auth = getAuth();
  const [user, loading] = useAuthState(auth);
  const router = useRouter();

  
  useEffect(() => {
    if (user) {
      const checkUserRole = async () => {
        const token = await user.getIdTokenResult();
        const role = token.claims.role;
        if (role === "admin") {
          router.push('/mentors');
        } else {
          console.log("User does not have the admin role.");
        }
      };
      checkUserRole();
    }
  }, [user]);

  if (loading) {
    return <div>Loading...</div>;
  }

  const handleLogin = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    await signInWithEmailAndPassword(auth, email, password)
      .then((userCredential) => {
        console.log("usercredential:", userCredential);
      })
      .catch((error) => {
        console.log(error.message);
      });
  };


  return (
    <div style={styles.container}>
      <div style={styles.imageContainer}>
        <Image src="/gradient.png" height={1500} width={700} alt="gradient" />
      </div>
      <div style={styles.formContainer}>
        <h3>Login</h3>
        <form onSubmit={handleLogin}>
          <p>Email</p>
          <input
            style={styles.inputField}
            type="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <p>Password</p>
          <input
            style={styles.inputField}
            type="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <button type="submit">Login</button>
        </form>
      </div>
    </div>
  );
};

const styles = {
  container: {
    display: 'flex',
    height: '100vh',
    borderLeft: 'none',
    margin: 0,
    padding: 0,
  },
  imageContainer: {
    flex: 1,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    margin: 0,
    padding: 0,
  },
  formContainer: {
    flex: 1,
    display: 'flex',
    alignItems: 'center',
    flexDirection: 'column',
    justifyContent: 'center',
    background: '#fff',
  },
  inputField: {
    width: '30vw',
    borderRadius: '13px',
    padding: '8px',
  }
};
