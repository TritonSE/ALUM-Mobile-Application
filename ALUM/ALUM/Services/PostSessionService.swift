//
//  PostSessionService.swift
//  ALUM
//
//  Created by Adhithya Ananthan on 4/26/23.
//  This file will contain the service function to make a post session route
//  Note that the function in this file should be added to the SessionService page
//  once everything is merged
//

import Foundation


struct SessionPostData: Codable {
    var menteeId: String
    var mentorId: String
    var calendlyURI: String
}

struct PostSessionData: Codable {
    var sessionId: String
    var menteeId: String
    var mentorId: String
}

class PostSessionService {
    func postSessionWithId(menteeId: String, mentorId: String, calendlyURI: String) async throws -> PostSessionData?  {
        let urlObj = URL(string: "http://localhost:3000/sessions")!
        var request = URLRequest(url: urlObj)
        
        /*
        guard let authToken = try await UserService().getCurrentAuth() else {
                print("Could not get auth token")
                throw APIError.invalidRequest(message: "Could not get auth token")
        }
         */
        
        // Add Authtoken here for testing and comment above function
        let authToken = ""
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionBodyData = SessionPostData(menteeId: menteeId, mentorId: mentorId, calendlyURI: calendlyURI)
        
        guard let jsonData = try? JSONEncoder().encode(sessionBodyData) else {
            throw APIError.invalidRequest(message: "Error encoding JSON Data")
        }
        
        do {
            request.httpBody =  jsonData
            
            let (responseData, response) = try await URLSession.shared.data(for: request)
            // Check the response status code

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networkError()
            }

            if httpResponse.statusCode != 201 {
                let responseStr = String(decoding: responseData, as: UTF8.self)
                throw APIError.invalidRequest(
                    message: "Error { code: \(httpResponse.statusCode), message: \(responseStr) }"
                )
            } else {
                print("POST (http://localhost:3000/sessions) was successful.")
                guard let sessionData = try? JSONDecoder().decode(PostSessionData.self, from: responseData) else {
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
