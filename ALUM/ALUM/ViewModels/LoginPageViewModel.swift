//
//  LoginPageViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/15/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth

final class LoginPageViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var disabled: Bool = true
    @Published var userIsLoggedIn: Bool = false
    @Published var emailFunc: [(String) -> (Bool, String)] = []
    @Published var passFunc: [(String) -> (Bool, String)] = []
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let maybeError = error {
                let errorCode = AuthErrorCode.Code(rawValue: maybeError._code)
                if errorCode == .invalidEmail {
                    print("Invalid Email")
                    self.emailFunc = [Functions.InvalidEmail]
                } else if errorCode == .wrongPassword {
                    print("wrong password")
                    self.passFunc = [Functions.IncorrectPassword]
                } else if errorCode == .userNotFound {
                    print("User not found")
                    self.emailFunc = [Functions.IncorrectEmail]
                }
            } else {
                print("success")
                self.userIsLoggedIn.toggle()
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
