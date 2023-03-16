//
//  FirebaseAuthentication.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/16/23.
//

import Foundation
import FirebaseAuth
import FirebaseCore


func getIdToken() {
    if let currentUser = Auth.auth().currentUser {
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("Error getting ID token: \(error.localizedDescription)")
            } else if let idToken = idToken {
                print(idToken)
                return
            }
        }
    }
}
