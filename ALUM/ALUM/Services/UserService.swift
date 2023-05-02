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

    /// This function sends the request and performs check on the received response to see if there was
    /// any error (network error, invalid request, etc.).
    ///
    /// If yes, the errors are thrown. Otherwise response data is returned
    private func sendRequestWithSafety(route: APIRoute, request: URLRequest) async throws -> Data {
        let responseData: Data, response: URLResponse
        print("\(route.label) - sending request")
        // Any transport error (network error etc.) would happen when sending the request,
        // hence the do-catch
        do {
            (responseData, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw AppError.actionable(.networkError, message: route.label)
        }

        // Ensure that response is of corrcet type
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.internalError(
                .invalidResponse,
                message: "Expected HTTPURLResponse for getMentor route but found somrthing else"
            )
        }

        // Handle case where response is not success. successCode for each route stored on APIRoute
        if httpResponse.statusCode != route.successCode {
            let responseStr = String(decoding: responseData, as: UTF8.self)
            throw route.getAppError(statusCode: httpResponse.statusCode, message: responseStr)
        }

        // All good -- so return data
        return responseData
    }

    func createMentee(data: MenteePostData) async throws {
        let route = APIRoute.postMentee
        var request = try await route.createURLRequest()
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw AppError.internalError(.jsonParsingError, message: "Failed to Encode Data")
        }
        request.httpBody = jsonData
        let responseData = try await self.sendRequestWithSafety(route: route, request: request)
        print("SUCCESS - \(route.label)")
    }

    func createMentor(data: MentorPostData) async throws {
        let route = APIRoute.postMentor
        var request = try await route.createURLRequest()
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw AppError.internalError(.jsonParsingError, message: "Failed to Encode Data")
        }
        request.httpBody = jsonData
        let responseData = try await self.sendRequestWithSafety(route: route, request: request)
        print("SUCCESS - \(route.label)")
    }

    func getMentor(userID: String) async throws -> MentorGetData {
        let route = APIRoute.getMentor(userId: userID)
        let request = try await route.createURLRequest()
        let responseData = try await self.sendRequestWithSafety(route: route, request: request)
        guard let mentorData = try? JSONDecoder().decode(MentorGetData.self, from: responseData) else {
            throw AppError.internalError(.invalidResponse, message: "Failed to Decode Data")
        }
        print("SUCCESS - \(route.label)")
        return mentorData
    }

    func getMentee(userID: String) async throws -> MenteeGetData {
        let route = APIRoute.getMentee(userId: userID)
        let request = try await route.createURLRequest()
        let responseData = try await self.sendRequestWithSafety(route: route, request: request)
        guard let menteeData = try? JSONDecoder().decode(MenteeGetData.self, from: responseData) else {
            throw AppError.internalError(.invalidResponse, message: "Failed to Decode Data")
        }
        print("SUCCESS - \(route.label)")
        return menteeData
    }
}
