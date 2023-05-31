import React from 'react';
import '../../styles/globals.css'
import Image from 'next/image';

export default function Login(){
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
        </form>
        <button type="submit">Login</button>
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