import * as functions from "firebase-functions";


export const addUserToDummyCollection = functions.region('asia-south1').
firestore
    .document('Friends')
    .onCreate((snap: any, context: any) => {
    const data = snap.data();
    console.log(data);

    });
