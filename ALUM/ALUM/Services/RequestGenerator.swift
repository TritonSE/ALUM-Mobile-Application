//
//  RequestGenerator.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/24/23.
//

import Foundation

class RequestGenerator {
    static let shared = RequestGenerator()

    func attachAuthTokenToRequest(request: inout URLRequest) async throws {
        guard let authToken = try await FirebaseAuthenticationService.shared.getCurrentAuth() else {
            throw APIError.authenticationError(
                message: "Error getting auth token"
            )
        }
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
    }

    func createRequest(urlString: String, method: String, requireAuth: Bool) async throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            print("Url Failure")
            throw APIError.invalidRequest()
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if requireAuth {
            try await attachAuthTokenToRequest(request: &request)
        }
        return request
    }
    // Add more functions for PUT, DELETE, etc. as needed
}
