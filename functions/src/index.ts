import * as admin from "firebase-admin";
import { addUserToDummyCollection } from "./add_user/add_user_to_dummy";

admin.initializeApp();

export {
    addUserToDummyCollection
}

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
