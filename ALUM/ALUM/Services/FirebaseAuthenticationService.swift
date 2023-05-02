//
//  FirebaseAuthentication.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/16/23.
//

import SwiftUI
import FirebaseAuth

final class FirebaseAuthenticationService: ObservableObject {
    static let shared = FirebaseAuthenticationService()

    @ObservedObject var currentUser: CurrentUserModal = CurrentUserModal.shared

    func login(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        try await currentUser.setFromFirebaseUser(user: result.user)
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            self.currentUser.setCurrentUser(isLoading: false, isLoggedIn: false, uid: nil, role: nil)
            print("logged out successfuly")
        } catch let error {
            print("error occured in FirebaseAuthenticationService - ", error.localizedDescription)
        }

    }

    func getCurrentAuth() async throws -> String? {
        if let currentUser = Auth.auth().currentUser {
            do {
                let tokenResult = try await currentUser.getIDTokenResult()
                return tokenResult.token
            } catch let error {
                // Handle the error
                throw APIError.authenticationError(
                    message: "Error getting auth token: \(error.localizedDescription)"
                )
            }
        } else {
            throw APIError.authenticationError(
                message: "No logged in user found. Please login first"
            )
        }
    }

}
