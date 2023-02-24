//
//  SignUpPageViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/17/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth

final class SignUpPageViewModel: ObservableObject {
    @Published var passwordAgain: String = ""
    @Published var disabled: Bool = true
    @Published var emailFunc: [(String) -> (Bool, String)] = []
    @Published var passFunc: [(String) -> (Bool, String)] = []
    @Published var passAgainFunc: [(String) -> (Bool, String)] = []
    @Published var isMentee = false
    @Published var isMentor = false
    @Published var setUpIsInvalid = false
    
    @Published var account = Account(name: "", email: "", password: "")
    @Published var mentee = Mentee(name: "", email: "", grade: "", mentorshipGoal: "", password: "")
    
    func setUpMentee() {
        mentee.name = account.name
        mentee.email = account.email
        mentee.password = account.password
        print("Hello World")
        print(mentee.name)
    }
    
    func checkPasswordSame() {
        if !(self.account.password == self.passwordAgain) {
            self.passAgainFunc = [SignUpPageViewModel.Functions.passNotSame]
        } else {
            self.passAgainFunc = []
        }
    }
    
    class Functions {
        static let IUSDEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            if string.contains("iusd.edu") {
                return (false, "Don't use IUSD email")
            } else {
                return (true, "Don't use IUSD email")
            }
        }
        
        static let ValidEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            if string.contains("@") {
                return (true, "Valid email")
            } else {
                return (false, "Invalid email")
            }
        }

        static let EightChars: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            if string.count <= 8 {
                return (false, "At least 8 characters")
            } else {
                return (true, "At least 8 characters")
            }
        }

        static let OneNumber: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            var hasNumber: Bool = false
            for character in string {
                if character.isNumber {
                    hasNumber = true
                    break
                }
            }

            if hasNumber {
                return (true, "At least 8 characters")
            } else {
                return (false, "At least 8 characters")
            }
        }

        static let SpecialChar: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            var hasSpecial: Bool = false
            let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
            if string.rangeOfCharacter(from: characterset.inverted) != nil {
                hasSpecial = true
            }

            if hasSpecial {
                return (true, "At least 1 special character")
            } else {
                return (false, "At least 1 special character")
            }
        }
        
        static let passNotSame: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            return (false, "Passwords do not match")
        }
    }
}
