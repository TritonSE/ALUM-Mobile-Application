"use client"

import {useAuthState} from "react-firebase-hooks/auth";
import { getAuth } from "firebase/auth";
import { useRouter } from "next/navigation";
import { initializeFirebase } from "../../../../backend/firebase";
export default function MentorsPage() {
  const app = initializeFirebase();
  const auth=getAuth();
  const router=useRouter();
  const [user, loading] = useAuthState(auth);
  if(loading){
    return <div>Loading.</div>
  }
  if(!user){
    router.push('/login');
  }
    return (
      <>
        <main>
          <div>{'This is the mentors page!'}</div>
        </main>
      </>
    );
  }
  