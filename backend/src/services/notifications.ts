import * as admin from 'firebase-admin';

async function sendNotification(title: string, body: string, deviceToken: string) {
    const message = {
        notification: {
          title: title,
          body: body,
        },
        token: "dm8czbE_cUXvn3oQSveO2X:APA91bFXOMa7M-BcZpxShpUYm8XtfMUgN9IsnKA3uirE-yo3S3IvwsXWoYc-MgsvwZG3N4LQiw7LASZCA9F4iTIQkUKtA34vx3wMvBE2PbfVm0ZDX93VAaYqTjdFVbmyUhhCkf2fIY9M",
      };

      admin.messaging().send(message)
        .then((response) => {
            console.log('Notification sent successfully:', response);
        })
        .catch((error) => {
            console.error('Error sending notification:', error);
        });
}

export {sendNotification};