import React from 'react';
import '../../styles/globals.css'
import Image from 'next/image';
import { initializeFirebase } from '../../../backend/firebase';

const handleLogin = async (event: React.FormEvent<HTMLFormElement>) => {
  event.preventDefault();

  const email = event.currentTarget.email.value;
  const password = event.currentTarget.password.value;

  // try {
  //   signInWithEmailAndPassword(firebaseAuth, email, password)
  // .then((userCredential) => {
  //   const user = userCredential.user;
  //   console.log(user);
  //   console.log("success");
  // })˜
  // .catch((error) => {
  //   const errorCode = error.code;
  //   const errorMessage = error.message;
  // });
  // } catch (error) {
  //   // Handle login errors
  //   console.log(error);
  // }
};

export default function Login(){
  const firebase = initializeFirebase();
  console.log(firebase);
  return (
    <div style={styles.container}>
      <div style={styles.imageContainer}>
      <Image
      src="/gradient.png" height={1500} width={700} alt="gradient" />
      </div>
      <div style={styles.formContainer}>
        <h3>Login</h3>
        <form>
                    <p>Email</p>
          <input style={styles.inputField} type="password" placeholder="username" />
          <p>Password</p>
          <input style={styles.inputField} type="username" placeholder="password" />
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