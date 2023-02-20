/**
 * This file consists of functions to be used to add
 * users to Firebase. Could potentially be configured to add
 * neccessary user info to Mongo DB (i.e uid linking user from
 * firebase to MongoDB)
 */

import { ValidationError } from "../errors/validationError";
import { firebaseAuth } from "./firebase";

/**
 * This function creates a user in firebase
 * @param uid: Id for user, note this MUST be the same uid in MongoDb
 * @param email: email of user, note it must not have **@iusd.org
 * @param password: password of user
 * @returns
 */
async function createUser(uid: string, email: string, password: string) {
  try {
    const userRecord = await firebaseAuth.createUser({
      uid,
      email,
      password,
    });
    return userRecord;
  } catch (e) {
    throw ValidationError.USED_EMAIL;
  }
}

export { createUser };
