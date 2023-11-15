import app from "./config";
import { getAuth, onAuthStateChanged } from "firebase/auth";
import signIn from "./signin";

const auth = getAuth(app);
signIn("admin@gmail.com", "12345678#");

export async function getToken() {
    onAuthStateChanged(auth, (user) => {
        if (user) {
            return user.getIdToken()
        }
    })        
}
