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
        /*
        guard let authToken = try await FirebaseAuthenticationService.shared.getCurrentAuth() else {
            throw AppError.actionable(.authenticationError, message: "Error getting auth token")
        }
         */
        // swiftlint:disable:next line_length
        let authToken  = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImQwZTFkMjM5MDllNzZmZjRhNzJlZTA4ODUxOWM5M2JiOTg4ZjE4NDUiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudGVlIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4NDYxMDA3NCwidXNlcl9pZCI6IjY0MzFiOTllYmNmNDQyMGZlOTgyNWZlMyIsInN1YiI6IjY0MzFiOTllYmNmNDQyMGZlOTgyNWZlMyIsImlhdCI6MTY4NDYxMDA3NCwiZXhwIjoxNjg0NjEzNjc0LCJlbWFpbCI6Im1lbnRlZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudGVlQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.F54z9actGV2EUvtKV43p13gAXGmwfm1YnUvEoBNGCA-8MbF7yzg-QSHKCkoiHSaL4Pr96uyfPGOkjlvis52kvgkKyBzz14Uq_LNAzzRnReN8KMvxJ97ZVbVVCSZH3HUm3JK26G4PaCFE3MXcFs7Ess9JRAaVtlf-jWj5bLH9otH0ba8sPzbeYlIB7CQ7EkcAjBcem8gwuwAO9BbWPD18KB5EAz8nBDAOuUcRJKPsJWDY-fstxW3XI2hVm88_438Pt9SiE1-tUdzfqWQjk9wYgFXV4KJjqSAMA5HeCl0IPx1DH7jMc9tucDuiqvWIESEOeByCu8u1t8-HbhNaZf8jYQ"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
    }

    func createRequest(urlString: String, method: String, requireAuth: Bool) async throws -> URLRequest {
        guard let url = URL(string: urlString) else {
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
            throw AppError.actionable(.networkError, message: route.label)
        }

        // Ensure that response is of corrcet type
        guard let httpResponse = response as? HTTPURLResponse else {
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
