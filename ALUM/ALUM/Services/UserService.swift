//
//  APIService.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/1/23.
//
import Foundation
import FirebaseAuth

struct MenteePostData: Codable {
    var name: String
    var email: String
    var password: String
    var grade: Int
    var topicsOfInterest: Set<String>
    var careerInterests: Set<String>
    var mentorshipGoal: String
}

struct MentorPostData: Codable {
    var name: String
    var email: String
    var password: String
    var graduationYear: Int
    var college: String
    var major: String
    var minor: String
    var career: String
    var topicsOfExpertise: Set<String>
    var mentorMotivation: String
    var location: String
    var calendlyLink: String
    var personalAccessToken: String
}

struct MenteeGetData: Decodable {
    var message: String
    var mentee: MenteeInfo
}

struct MentorGetData: Decodable {
    var message: String
    var mentor: MentorInfo
}

/// This class deals with all communications with mentor / mentee routes on the backend.
/// Each public method of this service
class UserService {
    static let shared = UserService()

    func createMentee(data: MenteePostData) async throws {
        let route = APIRoute.postMentee
        var request = try await route.createURLRequest()
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw AppError.internalError(.jsonParsingError, message: "Failed to Encode Data")
        }
        request.httpBody = jsonData
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        print("SUCCESS - \(route.label)")
    }

    func createMentor(data: MentorPostData) async throws {
        let route = APIRoute.postMentor
        var request = try await route.createURLRequest()
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw AppError.internalError(.jsonParsingError, message: "Failed to Encode Data")
        }
        request.httpBody = jsonData
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        print("SUCCESS - \(route.label)")
    }

    func getMentor(userID: String) async throws -> MentorGetData {
        let route = APIRoute.getMentor(userId: userID)
        let request = try await route.createURLRequest()
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        let mentorData = try handleDecodingErrors({
            try JSONDecoder().decode(MentorGetData.self, from: responseData)
        })
        print("SUCCESS - \(route.label)")
        return mentorData
    }

    func getMentee(userID: String) async throws -> MenteeGetData {
        let route = APIRoute.getMentee(userId: userID)
        let request = try await route.createURLRequest()
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        
        let menteeData = try handleDecodingErrors({
            try JSONDecoder().decode(MenteeGetData.self, from: responseData)
        })
        
        print("SUCCESS - \(route.label)")
        return menteeData
    }
}
