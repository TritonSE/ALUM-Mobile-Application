//
//  SessionService.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

struct SessionInfo: Decodable {
    var preSession: String
    var postSession: String
    var menteeId: String
    var mentorId: String
    var dateTime: String
}

struct GetSessionData: Decodable {
    var message: String
    var session: SessionInfo
}

class SessionService {
    func getSessionWithID(sessionID: String) async throws -> GetSessionData? {
        let urlObj = URL(string: "http://localhost:3000/sessions/" + sessionID)!
        var request = URLRequest(url: urlObj)

        /*
        guard let authToken = try await UserService().getCurrentAuth() else {
            print("Could not get auth token")
            throw APIError.invalidRequest(message: "Could not get auth token")
        }
         */

        // swiftlint:disable:next line_length
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImU3OTMwMjdkYWI0YzcwNmQ2ODg0NGI4MDk2ZTBlYzQzMjYyMjIwMDAiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MjU2MjkzNywidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MjU2MjkzNywiZXhwIjoxNjgyNTY2NTM3LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.iD_WinhxNTxkGAffS5mWTh_7JBp1gKzgUHZ4hw1iT8knJqTQPF2924017cQD9Ndy6GOciS2CPsODQYbBt55HlFioqxFgZdaTmZXXOCL-XLfBYtlpcgZWKGzu0oP08vwH1PJv0QoCzT9MbDnVQkxToclqqEcXRZlwnPC05OC2Ty4QTP2-o0hmDb-NFwTwmaXoTd7Ni2tkVJBrXO-6sP286HXD6ysrA4QEeruARLjHEO1vRDxYZs-VGjsZhg1biGt2yTiO3wZClA9TxoVxlp1Ll0m-B0vJIoyIIoqRXyGVG0krrV_igoY8D1R2lhu84EFpWWwg4YtnAu3gF8kQskOXYw"
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (responseData, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networkError()
            }
            if httpResponse.statusCode != 200 {
                let responseStr = String(decoding: responseData, as: UTF8.self)
                throw APIError.invalidRequest(
                    message: "Error { code: \(httpResponse.statusCode), message: \(responseStr) }"
                )
            } else {
                print("GET \("http://localhost:3000/sessions/" + sessionID) was successful.")
                guard let sessionData = try? JSONDecoder().decode(GetSessionData.self, from: responseData) else {
                    print("Failed to decode data")
                    throw APIError.invalidRequest(message: "Could not decode data")
                }
                return sessionData
            }
        } catch {
            print(error)
            throw error
        }
    }
}
