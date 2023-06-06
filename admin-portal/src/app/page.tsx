"use client";

import Image from 'next/image'
import { useEffect } from 'react';
import { useRouter } from 'next/navigation';

import styles from '@/styles/Page.module.css'


export default function Home() {
  const router = useRouter();

  useEffect(() => {
    router.push('/login');
  });

  return (
      null
  );
};

