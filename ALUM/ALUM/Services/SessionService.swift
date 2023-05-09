//
//  SessionService.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

struct SessionInfo: Decodable {
    var preSession: String
    var postSessionMentee: String?
    var postSessionMentor: String?
    var menteeId: String
    var mentorId: String
    var dateTime: String
    var preSessionCompleted: Bool?
    var postSessionMenteeCompleted: Bool?
    var postSessionMentorCompleted: Bool?
}

struct GetSessionData: Decodable {
    var message: String
    var session: SessionInfo
}

struct UserSessionInfo: Decodable {
    var id: String
    var dateTime: String?
    var preSessionCompleted: Bool?
    var postSessionCompleted: Bool?
    var title: String
}

struct GetUserSessionsData: Decodable {
    var message: String
    var sessions: [UserSessionInfo]
}

class SessionService {
    /*
    func getSessionWithID(sessionID: String) async throws -> GetSessionData? {
        let urlObj = URL(string: "http://localhost:3000/sessions/" + sessionID)!
        var request = URLRequest(url: urlObj)

        guard let authToken = try await UserService().getCurrentAuth() else {
            print("Could not get auth token")
            throw APIError.invalidRequest(message: "Could not get auth token")
        }

        request.httpMethod = "GET"
        request = try await UserService().attachTokenToRequest(request: request)
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
    */
    
    func getSessionWithID(sessionID: String) async throws -> GetSessionData {
        let route = APIRoute.getSession(sessionId: sessionID)
        let request = try await route.createURLRequest()
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        
        do {
            let sessionData = try JSONDecoder().decode(GetSessionData.self, from: responseData)
            print("SUCCESS - \(route.label)")
            return sessionData
        } catch {
            print("Failed to decode data")
            throw AppError.internalError(.jsonParsingError, message: "Failed to decode data")
        }
    }
    
    func getSessionsByUser() async throws -> GetUserSessionsData {
        let route = APIRoute.getSessions
        let request = try await route.createURLRequest()
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        
        do {
            let sessionsData = try JSONDecoder().decode(GetUserSessionsData.self, from: responseData)
            print("SUCCESS - \(route.label)")
            return sessionsData
        } catch {
            print("Failed to decode data")
            throw AppError.internalError(.jsonParsingError, message: "Failed to decode data")
        }
    }
}
