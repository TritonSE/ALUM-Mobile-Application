import * as admin from "firebase-admin";
import schedule from "node-schedule";
import { Mentee, Mentor, Session } from "../models";
import { ServiceError } from "../errors";

/**
 * Unicode notes:
 * eyes - 1F440
 * cool with glasses - 1F60E
 * check mark - 2705
 * broken heart - 1F494
 *
 * To find emojis and their unicode value, use https://apps.timwhitlock.info/emoji/tables/unicode
 * The unicode is in format "U+1234"; in code, use "\u{1234}"
 */

async function sendNotification(title: string, body: string, deviceToken: string) {
  const message = {
    notification: {
      title,
      body,
    },
    token: deviceToken,
  };

  admin
    .messaging()
    .send(message)
    .then((response) => {
      console.log("Notification sent successfully:", response);
    })
    .catch(() => {
      throw ServiceError.ERROR_SENDING_NOTIFICATION;
    });
}

async function startUpcomingSessionCronJob() {
  schedule.scheduleJob("*/1 * * * *", async () => {
    try {
      const upcomingNotifSessions = await Session.find({
        upcomingSessionNotifSent: { $eq: false },
      });
      upcomingNotifSessions.forEach(async (session) => {
        const dateNow = new Date();
        const mentee = await Mentee.findById(session.menteeId);
        if (!mentee) {
          // Instead of throwing an error, we skip this current iteration to avoid skipping the rest of the sessions.
          return;
        }
        const mentor = await Mentor.findById(session.mentorId);
        if (!mentor) {
          return;
        }

        const headerText = `You have an upcoming session.`;
        let menteeNotifText = `Ready for your session with ${mentor.name} in 24 hours? \u{1F440}`;
        let mentorNotifText = `Ready for your session with ${mentee.name} in 24 hours? \u{1F440}`;

        if (session.startTime.getTime() - dateNow.getTime() <= 86400000) {
          if (session.preSessionCompleted) {
            mentorNotifText += `Check out ${mentee.name}'s pre-session notes.`;
          } else {
            menteeNotifText += `Fill out your pre-session notes now!`;
          }
          const menteeNotif = await sendNotification(headerText, menteeNotifText, mentee.fcmToken);
          console.log("Function executed successfully:", menteeNotif);
          const mentorNotif = await sendNotification(headerText, mentorNotifText, mentor.fcmToken);
          console.log("Function executed successfully:", mentorNotif);
          session.upcomingSessionNotifSent = true;
          await session.save();
        }
      });
    } catch (error) {
      console.error("Error executing function:", error);
    }
  });
}

async function startPostSessionCronJob() {
  schedule.scheduleJob("*/1 * * * *", async () => {
    try {
      const postNotifSessions = await Session.find({ postSessionNotifSent: { $eq: false } });
      postNotifSessions.forEach(async (session) => {
        const dateNow = new Date();
        const mentee = await Mentee.findById(session.menteeId);
        if (!mentee) {
          return;
        }
        const mentor = await Mentor.findById(session.mentorId);
        if (!mentor) {
          return;
        }
        // 600000 milliseconds = 10 minutes
        if (dateNow.getTime() - session.endTime.getTime() >= 600000) {
          // mentee notification
          await sendNotification(
            "\u{2705} Session complete!",
            "How did your session with " +
              mentor.name +
              " go? Jot it down in your post-session notes.",
            mentee.fcmToken
          );
          // mentor notification
          await sendNotification(
            "\u{2705} Session complete!",
            "How did your session with " +
              mentee.name +
              " go? Jot it down in your post-session notes.",
            mentor.fcmToken
          );
          session.postSessionNotifSent = true;
          await session.save();
        }
      });
    } catch (error) {
      console.error("Error executing function:", error);
    }
  });
}

export { sendNotification, startUpcomingSessionCronJob, startPostSessionCronJob };
