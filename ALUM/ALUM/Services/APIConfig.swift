//
//  APIConfig.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/1/23.
//

import Foundation

let baseURL: String = "http://localhost:3000"
struct URLString {
    static let mentor = "\(baseURL)/mentor"
    static let mentee = "\(baseURL)/mentee"
}

enum APIRoute {
    case getMentor(userId: String)
    case getMentee(userId: String)
    case postMentor
    case postMentee

    var url: String {
       switch self {
       case .getMentor(let userId):
           return "\(URLString.mentor)/\(userId)"
       case .getMentee(let userId):
           return "\(URLString.mentee)/\(userId)"
       case .postMentor:
           return URLString.mentor
       case .postMentee:
           return URLString.mentee
       }
    }

    var method: String {
        switch self {
        case .getMentee:
            return "GET"
        case .getMentor:
            return "GET"
        case .postMentor:
            return "POST"
        case .postMentee:
            return "POST"
        }
    }

    var requireAuth: Bool {
        switch self {
        case .getMentor, .getMentee:
            return true
        default:
            return false
        }
    }

    func createURLRequest() async throws -> URLRequest {
        return try await RequestGenerator.shared.createRequest(
            urlString: self.url,
            method: self.method,
            requireAuth: self.requireAuth
        )
    }
}
