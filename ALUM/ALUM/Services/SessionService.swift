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
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZGE4NmU4MWJkNTllMGE4Y2YzNTgwNTJiYjUzYjUzYjE4MzA3NzMiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0" +
        "b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MTk0MjYxNiwidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIs" +
        "InN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MTk0MjYxNiwiZXhwIjoxNjgxOTQ2MjE2LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2Us" +
        "ImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.eSYXeo4J_xwncROeDCjaf5UKcKHCPyg_bcvievQtI" +
        "2r0CGuK16YaBpERb5GimEoO3RNKkQqzdXtftTCFu5BuQNADd8yfVKTm3fMGmB74QjC5RvR7jLAPGyten9E3yDDFhkmo-Y8RKMM5Cb7aGz4SIppgiJBKHk7dRVADb5pYELli2hwQUsueVlB4Pp7RpBbL8ZB9whp" +
        "b3bYdaMOt9AuQgZisDnbKLZq1o4ao5Be193bI6EdpelzH56iOngihALfOra6tbDFLJaR-OwnrJGiIskyLVtzuEh_Nuoc1xTPontbARrD_Jlx3LTLW79Hgnc95LMJVpIBX0VK2rkyK0-gxcA"
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
