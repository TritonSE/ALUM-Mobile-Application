//
//  ForgotPasswordViewModel.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 5/9/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import SwiftUI

final class ForgotPasswordViewModel: ObservableObject {
    @Published var emailFunc: [(String) -> (Bool, String)] = []

    @Published var account = Account(name: "", email: "", password: "")
    func resetPassword() async {
        do {
            try await FirebaseAuthenticationService.shared.resetPassword(email: account.email)
        } catch let error as NSError {
            switch AuthErrorCode.Code(rawValue: error.code) {
            case .invalidEmail:
                self.emailFunc = [Functions.InvalidEmail]
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
        static let IncorrectEmail: (String) -> (Bool, String) = {(_: String) -> (Bool, String) in
            return (false, "Account doesn't exist for this email")
        }
        static let InvalidEmail: (String) -> (Bool, String) = {(_: String) -> (Bool, String) in
            return (false, "Please enter a valid email address")
        }
    }
}
