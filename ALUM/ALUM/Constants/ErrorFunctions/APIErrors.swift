//
//  APIErrors.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/10/23.
//

import Foundation

enum APIError: Error {
    case networkError(message: String = "")
    case serverError(message: String = "")
    case authenticationError(message: String = "")
    case invalidRequest(message: String = "")
}
