//
//  SessionService.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

struct GetSessionData: Decodable {
    var preSession: String
    var postSession: String
    var menteeId: String
    var mentorId: String
    var dateTime: Date
}

class SessionService {
    func getSessionWithID(url: String) async throws -> GetSessionData {
        let urlObj = URL(string: url)!
        var request = URLRequest(url: urlObj)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (responseData, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networkError()
            }
            if httpResponse.statusCode != 201 {
                let responseStr = String(decoding: responseData, as: UTF8.self)
                throw APIError.invalidRequest(
                    message: "Error { code: \(httpResponse.statusCode), message: \(responseStr) }"
                )
            } else {
                guard let sessionData = try JSONDecoder().decode(GetSessionData.self, from: responseData) as? GetSessionData else {
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
