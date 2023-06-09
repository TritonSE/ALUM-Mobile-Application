//
//  RequestGenerator.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/24/23.
//

import Foundation

class ServiceHelper {
    static let shared = ServiceHelper()

    func attachAuthTokenToRequest(request: inout URLRequest) async throws {
        guard let authToken = try await FirebaseAuthenticationService.shared.getCurrentAuth() else {
            DispatchQueue.main.async {
                CurrentUserModel.shared.showInternalError.toggle()
            }
            throw AppError.actionable(.authenticationError, message: "Error getting auth token")
        }
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
    }

    func createRequest(urlString: String, method: String, requireAuth: Bool) async throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                CurrentUserModel.shared.showInternalError.toggle()
            }
            throw AppError.internalError(.unknownError, message: "Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if requireAuth {
            try await attachAuthTokenToRequest(request: &request)
        }
        return request
    }

    /// This function sends the request and performs check on the received response to see if there was
    /// any error (network error, invalid request, etc.).
    ///
    /// If yes, the errors are thrown. Otherwise response data is returned
    func sendRequestWithSafety(route: APIRoute, request: URLRequest) async throws -> Data {
        let responseData: Data, response: URLResponse
        print("\(route.label) - sending request")
        // Any transport error (network error etc.) would happen when sending the request,
        // hence the do-catch
        do {
            (responseData, response) = try await URLSession.shared.data(for: request)
        } catch {
            DispatchQueue.main.async {
                CurrentUserModel.shared.showNetworkError = true
            }
            throw AppError.actionable(.networkError, message: route.label)
        }

        // Ensure that response is of corrcet type
        guard let httpResponse = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                CurrentUserModel.shared.showInternalError.toggle()
            }
            throw AppError.internalError(
                .invalidResponse,
                message: "Expected HTTPURLResponse for getMentor route but found somrthing else"
            )
        }

        // Handle case where response is not success. successCode for each route stored on APIRoute
        if httpResponse.statusCode != route.successCode {
            let responseStr = String(decoding: responseData, as: UTF8.self)
            throw route.getAppError(statusCode: httpResponse.statusCode, message: responseStr)
        }

        // All good -- so return data
        return responseData
    }
}
