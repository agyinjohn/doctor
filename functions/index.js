const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snap, context) => {
    const message = snap.data();
    const senderId = message.senderId;
    const chatId = context.params.chatId;

    const chatDoc = await admin
      .firestore()
      .collection("chats")
      .doc(chatId)
      .get();
    const participants = chatDoc
      .data()
      .participants.filter((id) => id !== senderId);

    const tokens = await getTokensForUsers(participants);

    const payload = {
      notification: {
        title: "New Message",
        body: message.text,
      },
    };

    await admin.messaging().sendToDevice(tokens, payload);
  });

async function getTokensForUsers(userIds) {
  const tokens = [];
  for (const userId of userIds) {
    const userDoc = await admin
      .firestore()
      .collection("users")
      .doc(userId)
      .get();
    tokens.push(userDoc.data().fcmToken);
  }
  return tokens;
}
