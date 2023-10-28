import React from 'react';
import '../../../styles/Sessions.module.css'

const sessionsData = [
  { sessionDate: '2023-10-27', time: '10:00 AM', mentor: 'John', mentee: 'Alice', missedSession: 'Yes', reason: 'Sick' },
  { sessionDate: '2023-10-28', time: '2:00 PM', mentor: 'Mary', mentee: 'Bob', missedSession: 'No', reason: '' },
  // Add more data as needed
];

const SessionsTable = () => {
  return (
    <table className="sessions-table">
      <thead>
        <tr>
          <th>Session Date</th>
          <th>Time</th>
          <th>Mentor</th>
          <th>Mentee</th>
          <th>Missed Session</th>
          <th>Reason for Missing</th>
        </tr>
      </thead>
      <tbody>
        {sessionsData.map((session, index) => (
          <tr key={index} className={index % 2 === 0 ? 'even' : 'odd'}>
            <td>{session.sessionDate}</td>
            <td>{session.time}</td>
            <td>{session.mentor}</td>
            <td>{session.mentee}</td>
            <td>{session.missedSession}</td>
            <td>{session.reason}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

type GetSessionData = {
  message: string;
  session: GetSession;
}

type GetSession = {
  missedSessionReason: string;
  menteeId: string;
  mentorId: string;
  menteeName: string;
  mentorName: string;
  fullDateString: string;
  startTimeString: string;
  endTimeString: string;
}

async function getSessionData(sessionId: string, authKey: string) {
  // let url = "http://localhost:3000/sessions/651f985989d345b14690ad55";
  let url = "http://localhost:3000/sessions" + sessionId;
  // let key = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjBkMGU4NmJkNjQ3NDBjYWQyNDc1NjI4ZGEyZWM0OTZkZjUyYWRiNWQiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudGVlIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tZGV2LTcyZDRmIiwiYXVkIjoiYWx1bS1kZXYtNzJkNGYiLCJhdXRoX3RpbWUiOjE2OTgzODE2NjIsInVzZXJfaWQiOiI2NTFmMTVmMDRjM2FiNmM4ZWMwOTNhMjMiLCJzdWIiOiI2NTFmMTVmMDRjM2FiNmM4ZWMwOTNhMjMiLCJpYXQiOjE2OTgzODE2NjIsImV4cCI6MTY5ODM4NTI2MiwiZW1haWwiOiJtZW50ZWVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbIm1lbnRlZUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.cpCQ21nRR4ol-zmLBls0jygbnImnQr6bkwG87W1RZJOTDeM9IZfSAbJAh21abOh0LEYrkkXaMv76t0RC21fG4lIXzPHlT_PEbQWkUjaXz1s22MmWsDwV-ihddHb6RWaNo5KhuOD8T9wX5LfMPIPRZyP_RX0usK2wilZV7I5GITIY5JukblOlwJ25b80janOIdQ7m_BOvgGYn_MjTDDL0Pgl1nhfH7Z3P7tSEdPAEwABKCW3lomQcppY9rafboXldyMCTeQ3fLWZPYMj50f7inyblNqvxTsSpK3IW2rACjvlKrI_5UazZ0h22IeZ0P2LZRu1DfF4jjVaC1QEMwIBIvw";
  
  const headers = {
    Authorization: `Bearer ${authKey}`,
  };
  const res = await fetch(url, {headers});
  const data: GetSessionData = await res.json();
  return data
}

export default function SessionsPage() {
  
  return (
    <>
      <main>
        <div>
          <h1> 'This is the sessions page!' </h1>
          <SessionsTable />
        </div>
      </main>
    </>
  );
}
