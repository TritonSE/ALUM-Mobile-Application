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
    func convertDate(date: String) {
        var newDate = date
            .replacingOccurrences(of: "T", with: " ")
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: ":", with: " ")
        var dateComponents = newDate.components(separatedBy: " ")
        
    }
}
