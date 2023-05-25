import * as admin from 'firebase-admin';

async function sendNotification(title: string, body: string, deviceToken: string) {
    const message = {
        notification: {
          title: title,
          body: body,
        },
        token: deviceToken,
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