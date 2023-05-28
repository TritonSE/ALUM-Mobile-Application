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

func handleDecodingErrors<T>(_ decodingClosure: () throws -> T) throws -> T {
    var errorMessage: String
    do {
        return try decodingClosure()
    } catch let DecodingError.dataCorrupted(context) {
        errorMessage = "context: \(context)"
    } catch let DecodingError.keyNotFound(key, context) {
        errorMessage = "Key '\(key)' not found, context: \(context.debugDescription)"
    } catch let DecodingError.valueNotFound(value, context) {
        errorMessage = "Value '\(value)' not found, context: \(context.debugDescription)"
    } catch let DecodingError.typeMismatch(type, context)  {
        errorMessage = "Type '\(type)' mismatch:, context: \(context.debugDescription)"
    } catch {
        errorMessage = "Unknown: \(error)"
    }
    
    throw AppError.internalError(.invalidResponse, message: "Decode error - \(errorMessage)")
}
