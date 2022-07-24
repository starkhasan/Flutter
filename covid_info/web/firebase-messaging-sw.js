importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBsTkU3hx4cIh4ZchyeANufjg9ExH4iyRw",
  authDomain: "flutterpushnotification-81515.firebaseapp.com",
  databaseURL: "https://flutterpushnotification-81515-default-rtdb.firebaseio.com",
  projectId: "flutterpushnotification-81515",
  storageBucket: "flutterpushnotification-81515.appspot.com",
  messagingSenderId: "1066275591079",
  appId: "1:1066275591079:web:88d81ecee1c8f34e201c82",
  measurementId: "G-4DCHB33PDQ"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage(function(payload){
  console.log("onBackgroundMessage", m);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };
  self.registration.showNotification(notificationTitle,notificationOptions);
});