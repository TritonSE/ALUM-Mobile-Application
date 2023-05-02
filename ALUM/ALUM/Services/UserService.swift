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

class UserService {
    static let shared = UserService()

    func createUser(route: APIRoute, jsonData: Data) async throws {
        var request = try await route.createURLRequest()
        do {
            // Encode the data as JSON
            request.httpBody = jsonData
            // Make the network request
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
                print("POST \(route.url) was successful.")
            }
        } catch {
            print(error)
            throw error
        }
    }

    func createMentee(data: MenteePostData) async throws {
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw APIError.invalidRequest(
                message: "Failed to Encode Data"
            )
        }
        return try await self.createUser(route: APIRoute.postMentee, jsonData: jsonData)
    }

    func createMentor(data: MentorPostData) async throws {
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw APIError.invalidRequest(
                message: "Failed to Encode Data"
            )
        }
        return try await self.createUser(route: APIRoute.postMentor, jsonData: jsonData)
    }

    func getMentor(userID: String) async throws -> MentorGetData {
        let route = APIRoute.getMentor(userId: userID)
        var request = try await route.createURLRequest()
        let (responseData, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Network Error")
            throw APIError.networkError()
        }

        if httpResponse.statusCode != 200 {
            let responseStr = String(decoding: responseData, as: UTF8.self)
            print("Status code wrong")
            throw APIError.invalidRequest(
                message: "Error { code: \(httpResponse.statusCode), message: \(responseStr) }"
            )
        }
        guard let mentorData = try? JSONDecoder().decode(MentorGetData.self, from: responseData) else {
            print("Failed to Decode Data")
            throw APIError.invalidRequest(
                message: "Failed to Decode Data"
            )
        }
        print("GET \(route.url) was successful.")
        return mentorData
    }

    func getMentee(userID: String) async throws -> MenteeGetData {
        let route = APIRoute.getMentee(userId: userID)
        var request = try await route.createURLRequest()
        let (responseData, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkError()
        }
        if httpResponse.statusCode != 200 {
            let responseStr = String(decoding: responseData, as: UTF8.self)
            throw APIError.invalidRequest(
                message: "Error { code: \(httpResponse.statusCode), message: \(responseStr) }"
            )
        }

        guard let menteeData = try? JSONDecoder().decode(MenteeGetData.self, from: responseData) else {
            throw APIError.invalidRequest(
                message: "Failed to Decode Data"
            )
        }
        print("GET \(route.url) was successful.")
        return menteeData
    }
}
