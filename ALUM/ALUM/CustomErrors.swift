//
//  error.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/4/23.
//

import Foundation

enum APIError: Error {
    case networkError(message: String = "")
    case serverError(message: String = "")
    case authenticationError(message: String = "")
    case invalidRequest(message: String = "")
}
