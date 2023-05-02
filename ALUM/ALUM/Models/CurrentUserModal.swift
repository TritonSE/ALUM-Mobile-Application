//
//  UserModel.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/26/23.
//

import SwiftUI
import FirebaseAuth

enum UserRole {
    case mentor
    case mentee
}

class CurrentUserModal: ObservableObject {
    static let shared = CurrentUserModal()

    @Published var isLoading: Bool
    @Published var uid: String?
    @Published var role: UserRole?
    @Published var isLoggedIn: Bool

    init() {
        self.isLoading = true
        self.isLoggedIn = false
        self.uid = nil
        self.role = nil
    }

    ///  Since async operations are involved, this function will limit updating the current 
    ///  user without using the DispatchQueue logic.
    ///  Not using DispatchQueue can casue race conditions which can crash our app
    func setCurrentUser(isLoading: Bool, isLoggedIn: Bool, uid: String?, role: UserRole?) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
            self.isLoggedIn = isLoggedIn
            self.uid = uid
            self.role = role
        }
    }

    /// Utilizes FirebaseAuth to get data on a logged in user (if any). Otherwise resets to not logged in state
    func setForInSessionUser() async {
        do {
            guard let user = Auth.auth().currentUser else {
                print("No user found")
                throw ALUMError.noLoggedInUserError
            }
            try await self.setFromFirebaseUser(user: user)
        } catch {
            self.setCurrentUser(isLoading: false, isLoggedIn: false, uid: nil, role: nil)
        }
    }

    /// User is a Firebase User so this function gets the ROLE and UID of the 
    /// logged in user if a firebase user is passed
    func setFromFirebaseUser(user: User) async throws {
        let result = try await user.getIDTokenResult()
        guard let role = result.claims["role"] as? String else {
            throw ALUMError.invalidUserError
        }
        let roleEnum: UserRole
        switch role {
        case "mentee":
            roleEnum = .mentee
        case "mentor":
            roleEnum = .mentor
        default:
            throw ALUMError.invalidUserError
        }
        self.setCurrentUser(isLoading: false, isLoggedIn: true, uid: user.uid, role: roleEnum)
    }
}
