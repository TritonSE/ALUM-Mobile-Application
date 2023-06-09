//
//  ErrorFunctions.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/5/23.
//

import Foundation

class ErrorFunctions {
    static let EnterEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        if string == "" {
            return (false, "Please enter your email")
        } else {
            return (true, "skip")
        }
    }
    
    static let IUSDEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        if string.contains("iusd.edu") || !(string.contains("@")) {
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
        for character in string where character.isNumber {
            hasNumber = true
            break
        }

        if hasNumber {
            return (true, "At least 1 number")
        } else {
            return (false, "At least 1 number")
        }
    }

    static let SpecialChar: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        var hasSpecial: Bool = false
        let characterset = CharacterSet(charactersIn:
                                            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if string.rangeOfCharacter(from: characterset.inverted) != nil {
            hasSpecial = true
        }

        if hasSpecial {
            return (true, "At least 1 special character")
        } else {
            return (false, "At least 1 special character")
        }
    }

    static let passNotSame: (String) -> (Bool, String) = {(_: String) -> (Bool, String) in
        return (false, "Passwords do not match")
    }
}
