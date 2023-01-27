/**
 * This file consists of functions to be used to add 
 * users to Firebase. Could potentially be configured to add
 * neccessary user info to Mongo DB (i.e uid linking user from
 * firebase to MongoDB)
 */

import { firebaseAuth } from "./firebase";

async function createUser(uid: string, email: string, password: string) {
    const userRecord = firebaseAuth.createUser({
        uid: uid,
        email: email,
        password: password
    })
    return userRecord
}


export { createUser }