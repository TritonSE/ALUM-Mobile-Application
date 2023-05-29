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
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkM2E0YTllYjY0OTk0YzUxM2YyYzhlMGMwMTY1MzEzN2U5NTg3Y2EiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4NTM4MTgwMiwidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4NTM4MTgwMiwiZXhwIjoxNjg1Mzg1NDAyLCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.GdABxmoMEx1tuMY9AiMyGQJlbn_c-9b0ZomD71H9yk3PRyGCxKWVhfQMu__Wx4N3fQArlaMpNXNdYD6EqaJCBiEw--ncSgXvPMwlk7jDtw4GRPlkO8OF2Ejs-7REC7niLd7zwwplPtiu-a206l_9Hlx01UgOEnhS5DeWxjycJgFDQcxnFtwPuKOguqxDxVYNBQsEJzD5dxAt4R7rOG2sulXqDVrc3_OVWfneRxRYsZupHu3-EPcfoIPW79god_-I10zN5jY5cwVwMHDzUQPFQxWDJiH2_P0mcnywBpq0HP0BAdC8ZfWK1b5q_yl5MJWgHapXxO7KYYtCo3Ju-cdufA"
        
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
