//
//  error.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/4/23.
//

import Foundation
import FirebaseAuth

enum AppError: Error {
    case actionable(ActionableError, message: String = "")
    case internalError(InternalError, message: String = "")
}

enum ActionableError: Error {
    case networkError // Action - connect to internet
    case authenticationError // Action - login again
    case userError // Action login again
}

enum InternalError: Error {
    case invalidResponse
    case invalidRequest
    case unknownError
    case jsonParsingError
}
