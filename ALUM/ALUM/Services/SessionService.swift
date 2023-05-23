//
//  SessionService.swift
//  ALUM
//
//  Created by Harsh Gurnani on 4/13/23.
//  PostSessionService.swift
//  ALUM
//

import Foundation

struct SessionInfo: Decodable {
    var preSession: String
    var postSessionMentee: String?
    var postSessionMentor: String?
    var menteeId: String
    var mentorId: String
    var startTime: String
    var endTime: String
    var day: String
    var preSessionCompleted: Bool
    var postSessionMenteeCompleted: Bool
    var postSessionMentorCompleted: Bool
    var hasPassed: Bool
}

struct GetSessionData: Decodable {
    var message: String
    var session: SessionInfo
}

struct UserSessionInfo: Decodable {
    var id: String
    var startTime: String
    var endTime: String
    var day: String
    var preSessionCompleted: Bool
    var postSessionCompleted: Bool
    var title: String
    var hasPassed: Bool
}

struct GetUserSessionsData: Decodable {
    var message: String
    var sessions: [UserSessionInfo]
}

struct SessionLink: Codable {
    var calendlyURI: String
}

struct PostSessionData: Codable {
    var sessionId: String
    var menteeId: String
    var mentorId: String
}

struct DefaultSessionData: Codable {
    var message: String
}

class SessionService {

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

    // IMPORTANT: only use this function to pass in dates of format:
    // "YYYY-MM-DDTHH-MM-SS", where
    // Y=>year
    // M=>month
    // D=>day
    // H=>Hour
    // M=>Minute
    // S=>Seconds
    // For example: "1995-12-17T03:24:00"
    func convertDate(date: String) -> [String] {
        var newDate = date
            .replacingOccurrences(of: "T", with: " ")
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: ":", with: " ")
        var dateComponents = newDate.components(separatedBy: " ")
        return dateComponents
    }

    func postSessionWithId(calendlyURI: String) async throws -> PostSessionData? {
          let route = APIRoute.postSession
          var request = try await route.createURLRequest()
          let sessionBodyData = SessionLink(calendlyURI: calendlyURI)
          guard let jsonData = try? JSONEncoder().encode(sessionBodyData) else {
              throw AppError.internalError(.invalidRequest, message: "Error encoding JSON Data")
          }
          request.httpBody = jsonData
          let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
          guard let sessionData = try? JSONDecoder().decode(PostSessionData.self, from: responseData) else {
              print("Failed to decode data")
              throw AppError.internalError(.invalidRequest, message: "Could not decode data")
          }
          print("SUCCESS - \(route.label)")
          return sessionData
    }
    
    func patchSessionWithId(sessionId: String, newCalendlyURI: String) async throws -> DefaultSessionData? {
        let route = APIRoute.patchSession(sessionId: sessionId)
        var request = try await route.createURLRequest()
        let sessionBodyData = SessionLink(calendlyURI: newCalendlyURI)
        guard let jsonData = try? JSONEncoder().encode(sessionBodyData) else {
            throw AppError.internalError(.invalidRequest, message: "Error encoding JSON Data")
        }
        request.httpBody = jsonData
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        guard let sessionData = try? JSONDecoder().decode(DefaultSessionData.self, from: responseData) else {
            print("Failed to decode data")
            throw AppError.internalError(.invalidRequest, message: "Could not decode data")
        }
        print("SUCCESS - \(route.label)")
        return sessionData
    }
    
    func deleteSessionWithId(sessionId: String) async throws -> DefaultSessionData? {
        let route = APIRoute.deleteSession(sessionId: sessionId)
        var request = try await route.createURLRequest()
        let responseData = try await
        ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        guard let sessionData = try? JSONDecoder().decode(DefaultSessionData.self, from: responseData) else {
            print("Failed to decode data")
            throw AppError.internalError(.invalidRequest, message: "Could not decode data")
        }
        print("SUCCESS - \(route.label)")
        return sessionData
                
    }
}
