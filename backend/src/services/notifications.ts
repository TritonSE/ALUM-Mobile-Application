import * as admin from "firebase-admin";
import schedule from "node-schedule";
import { Mentee, Mentor, Session } from "../models";

/**
 * Unicode notes:
 * eyes - 1F440
 * cool with glasses - 1F60E
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
    .catch((error) => {
      console.error("Error sending notification:", error);
    });
}


async function startUpcomingSessionCronJob() {
  let upcomingNotifSessions = await Session.find({ upcomingSessionNotifSent: { $eq: false } });
  const job = schedule.scheduleJob("*/5 * * * *", async () => {
    try {
      upcomingNotifSessions.forEach(async (session) => {
        const dateNow = new Date();
        const mentee = await Mentee.findById(session.menteeId);
        const mentor = await Mentor.findById(session.mentorId);
        if (session.startTime.getTime() - dateNow.getTime() <= 86400000 && mentee != null && mentor != null) {
          if (session.preSessionCompleted) {
            const menteeNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with " + mentor.name + " in 24 hours? " + "\u{1F440}",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M" //mentee.fcmToken
            );
            console.log("Function executed successfully:", menteeNotif);
            const mentorNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with " + mentee.name + " in 24 hours? " + "\u{1F440}. Check out " + mentee.name + "'s pre-session notes.",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M" //mentor.fcmToken
            );
            console.log("Function executed successfully:", mentorNotif);
          } else {
            const menteeNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with " + mentor.name + " in 24 hours? " + "\u{1F440}. Fill out your pre-session notes now!",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M"
              //mentee.fcmToken
            );
            console.log("Function executed successfully:", menteeNotif);
            const mentorNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with " + mentee.name + " in 24 hours? " + "\u{1F440}",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M"
              //mentor.fcmToken
            );
            console.log("Function executed successfully:", mentorNotif);
          }
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
  let postNotifSessions = await Session.find({ postSessionNotifSent: { $eq: false } });
  const job = schedule.scheduleJob("*/5 * * * *", async () => {
    try {
      postNotifSessions.forEach(async (session) => {
        const dateNow = new Date();
        const mentee = await Mentee.findById(session.menteeId);
        const mentor = await Mentor.findById(session.mentorId);
        if (dateNow.getTime() - session.endTime.getTime() >= 0 && mentee != null && mentor != null) {
          // mentee notification
          await sendNotification(
            "\u{2705} Session complete!",
            "How did your session with " + mentor.name + " go? Jot it down in your post-session notes.",
            "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M" //mentee.fcmToken
          );
          // mentor notification
          await sendNotification(
            "\u{2705} Session complete!",
            "How did your session with " + mentee.name + " go? Jot it down in your post-session notes.",
            "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M" //mentor.fcmToken
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
