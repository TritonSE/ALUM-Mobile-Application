import * as admin from 'firebase-admin';

async function sendNotification(title: string, body: string, deviceToken: string) {
    const message = {
        notification: {
          title: 'Notification Title',
          body: 'Notification Body',
        },
        token: 'device_registration_token',
      };

      admin.messaging().send(message)
        .then((response) => {
            console.log('Notification sent successfully:', response);
        })
        .catch((error) => {
            console.error('Error sending notification:', error);
        });
}