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
        let authToken =
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZGE4NmU4MWJkNTllMGE4Y2YzNTgwNTJiYjUzYjUzYjE4MzA3NzMiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6" +
        "Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MTkzMTAwNSwidXNlcl9pZCI6IjY0MzFiOWEy" +
        "YmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MTkzMTAwNSwiZXhwIjoxNjgxOTM0NjA1LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5j" +
        "b20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b" +
        "3JkIn19.OmhyE1JDMhh93mrAtO7iB7rdZpjZuXdK-WPLUpvnyzdwQcw_ucLAApSY0b7cKb7057ql3-oHK0sQvqjllvBSDfaJLFAvSZ6UU8KzkpxqwXWpCjROPejDpEU-Zr1AqWwaRry11B9" +
        "GfVAj7AvjZPHgmIXVXei410UcfkXHgQLTU_SjpZcXcZOrhNFZdx_hw3RBh-I714XgztNSYlc3utuUbEvtRcZC8kaeSThJLV5EYfHqujgSCPv9UYtqlFzUSBM--JpernhDk8wDe4n1g1mDXi" +
        "JmdjqPRiktSrBkwzt-EsydseZ2rc87B-BvgJDibE_Gve-1SM0gYwlbmMAeEQsjxw"
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
