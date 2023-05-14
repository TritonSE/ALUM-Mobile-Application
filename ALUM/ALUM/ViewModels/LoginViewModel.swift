//
//  LoginViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/15/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var disabled: Bool = true
    @Published var emailFunc: [(String) -> (Bool, String)] = []
    @Published var passFunc: [(String) -> (Bool, String)] = []
    @Published var isLoading: Bool = false

    func login() async {
        do {
            try await FirebaseAuthenticationService.shared.login(email: email, password: password)
        } catch let error as NSError {
            switch AuthErrorCode.Code(rawValue: error.code) {
            case .invalidEmail:
                self.emailFunc = [Functions.InvalidEmail]
            case .wrongPassword:
                self.passFunc = [Functions.IncorrectPassword]
            case .userNotFound:
                self.emailFunc = [Functions.IncorrectEmail]
            default:
                print("Some unknown error happened")
            }
        }
    }

    class Functions {
        static let EnterEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            if string == "" {
                return (false, "Please enter your email")
            } else {
                return (false, "skip")
            }
        }
        static let EnterPassword: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            if string == "" {
                return (false, "Please enter your password")
            } else {
                return (false, "skip")
            }
        }
        static let IncorrectPassword: (String) -> (Bool, String) = {(_: String) -> (Bool, String) in
            return (false, "Incorrect Password")
        }
        static let IncorrectEmail: (String) -> (Bool, String) = {(_: String) -> (Bool, String) in
            return (false, "Account doesn't exist for this email")
        }
        static let InvalidEmail: (String) -> (Bool, String) = {(_: String) -> (Bool, String) in
            return (false, "Please enter a valid email address")
        }
    }
}
