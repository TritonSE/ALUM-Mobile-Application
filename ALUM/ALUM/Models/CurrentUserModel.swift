//
//  CurrentUserModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 5/4/23.
//

import SwiftUI
import FirebaseAuth

enum UserRole {
    case mentor
    case mentee
}

class CurrentUserModel: ObservableObject {
    static let shared = CurrentUserModel()

    @Published var isLoading: Bool
    @Published var uid: String?
    @Published var role: UserRole?
    @Published var isLoggedIn: Bool
    @Published var status: String?
    @Published var showTabBar: Bool

    @Published var sessionId: String?
    @Published var pairedMentorId: String?
    @Published var pairedMenteeId: String?

    init() {
        self.isLoading = true
        self.isLoggedIn = false
        self.uid = nil
        self.role = nil
        self.status = nil
        self.showTabBar = true
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
                throw AppError.actionable(.authenticationError, message: "No user found")
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
            throw AppError.actionable(
                .authenticationError,
                message: "Expected to have a firebase role for user \(user.uid)"
            )
        }
        let roleEnum: UserRole
        switch role {
        case "mentee":
            roleEnum = .mentee
        case "mentor":
            roleEnum = .mentor
        default:
            throw AppError.actionable(
                .authenticationError,
                message: "Expected user role to be mentor OR mentee but found - \(role)"
            )
        }
        self.setCurrentUser(isLoading: true, isLoggedIn: true, uid: user.uid, role: roleEnum)
        try await self.fetchUserInfoFromServer(userId: user.uid, role: roleEnum)
        print("loading done", roleEnum)
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    func fetchUserInfoFromServer(userId: String, role: UserRole) async throws {
        let userData = try await UserService.shared.getSelf()
        let userStatus = userData.status
        
        DispatchQueue.main.async {
            self.status = userStatus
        }
        
        if userStatus != "paired" {
            print("early return")
            return
        }
        
        if self.role == .mentee {
            guard let userPairedMentorId = userData.pairedMentorId else {
                throw AppError.internalError(.invalidResponse, message: "Expected mentee to have a paired mentor Id")
            }
            print("userPairedMentorId - \(userPairedMentorId)")
            DispatchQueue.main.async {
                self.pairedMentorId = userPairedMentorId
            }
        } else if self.role == .mentor {
            guard let userPairedMenteeId = userData.pairedMenteeId else {
                throw AppError.internalError(.invalidResponse, message: "Expected mentor to have a paired mentee Id")
            }
            print("userPairedMenteeId - \(userPairedMenteeId)")
            DispatchQueue.main.async {
                self.pairedMenteeId = userPairedMenteeId
            }
        } 
        
        DispatchQueue.main.async {
            self.sessionId = userData.sessionId
        }
    }
    
    func getStatus(userID: String, roleEnum: UserRole) async throws -> String {
        let userStatus: String
        switch roleEnum {
        case .mentee:
            userStatus = try await UserService.shared.getMentee(userID: userID).mentee.status ?? ""
        case .mentor:
            userStatus = try await UserService.shared.getMentor(userID: userID).mentor.status ?? ""
        }
        return userStatus
    }
}
