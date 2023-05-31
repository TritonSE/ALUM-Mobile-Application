import * as admin from "firebase-admin";
import schedule from "node-schedule";
import { Mentee, Mentor, Session } from "../models";

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

async function startCronJob() {
  console.log("inside cron job function");
  let upcomingNotifSessions = await Session.find({ upcomingSessionNotifSent: { $eq: false } });
  const job = schedule.scheduleJob("*/1 * * * *", async () => {
    try {
      upcomingNotifSessions.forEach(async (session) => {
        const dateNow = new Date();
        const mentee = await Mentee.findById(session.menteeId);
        const mentor = await Mentor.findById(session.mentorId);
        if (session.startTime.getTime() - dateNow.getTime() <= 86400000 && mentee != null && mentor != null) {
          if (session.preSessionCompleted) {
            const menteeNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with  " + mentor.name + " in 24 hours? " + "\u{1F60E}",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M" //mentee.fcmToken
            );
            console.log("Function executed successfully:", menteeNotif);
            const mentorNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with  " + mentee.name + " in 24 hours? " + "\u{1F60E}. Check out " + mentee.name + "'s pre-session notes.",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M" //mentor.fcmToken
            );
            console.log("Function executed successfully:", mentorNotif);
          } else {
            const menteeNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with  " + mentor.name + " in 24 hours? " + "\u{1F60E}. Fill out your pre-session notes now!",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M"
              //mentee.fcmToken
            );
            console.log("Function executed successfully:", menteeNotif);
            const mentorNotif = await sendNotification(
              "You have an upcoming session.",
              "Ready for your session with  " + mentee.name + " in 24 hours? " + "\u{1F60E}",
              "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M"
              //mentor.fcmToken
            );
            console.log("Function executed successfully:", mentorNotif);
          }
        }
        session.upcomingSessionNotifSent = true;
        console.log("should have updated session flag");
      });
      console.log(job);

    } catch (error) {
      console.error("Error executing function:", error);
    }
  });
}

export { sendNotification, startCronJob };
