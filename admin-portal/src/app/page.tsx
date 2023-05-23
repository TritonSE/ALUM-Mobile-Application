import { useEffect } from 'react';
import { useRouter } from 'next/router';
import { Login } from './login/page';

const RootLayout = ({ children }) => {
  // Your root layout content and structure goes here
  return (
    <div>
      {/* Add any header, footer, or other common components */}
      {children}
    </div>
  );
};

export default function Home{  
const router = useRouter();

  useEffect(() => {
    router.push('/mentors');
  }, []);

  return (
    <RootLayout>
      <Login />
    </RootLayout>
  );
};

