"use client";
import { useUser } from "@auth0/nextjs-auth0/client";

const home = () => {
  // eslint-disable-next-line react-hooks/rules-of-hooks
  const { user, error, isLoading } = useUser();

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>{error.message}</div>;

  if (user) {
    const getReadings = async () => {
      const response = await fetch("/api/all_records");
      const ret = await response.json();
      console.log(ret);
    };
    return <button onClick={getReadings}>Get All Records</button>;
  }
  return (
    <a href="/api/auth/login">Login</a>
  );
};

export default home;
