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
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImI2NzE1ZTJmZjcxZDIyMjQ5ODk1MDAyMzY2ODMwNDc3Mjg2Nzg0ZTMiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MzY2OTM5NSwidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MzY2OTM5NSwiZXhwIjoxNjgzNjcyOTk1LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.sGKUhrtjgZUBQKkg7d5Llp8TVTKbmekzxLroZqd6L4csowaLM-6EmgckkTsspII9Dhlrg86nraTBWN9NXn_yGy9LqtCgcleF1G6hIUNHGmHunA_9iDuip8PYJAIbnVT2aTqAe49YUCMy79RbeoYecve63pmCH_U0W6xcKBKncD2tauW-trfsAWVq0B1dy2RHxPGSrLkyH7HK9r9Yc05hHfvlDo2NGqKVNX8Kj_gjm7WU_eiXdXB8_LpkrSWBekBoZzbzdkkpXTOKrr5nmXQ8myKNGujpgxrFfevmNOFCxD4a629louJ9gAIMCKKR_t8uM70R5fLjQluYSYQPRxthog"
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
