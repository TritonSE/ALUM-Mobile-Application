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


struct SessionLink: Codable {
    var calendlyURI: String
}

struct PostSessionData: Codable {
    var sessionId: String
    var menteeId: String
    var mentorId: String
}

class SessionService {
    func postSessionWithId(calendlyURI: String) async throws -> PostSessionData?  {
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
}
