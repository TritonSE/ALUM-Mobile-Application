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
}

class UserService {
    func createUser(url: String, jsonData: Data) async throws {
        // Create a URL request with JSON content type
        let urlObj = URL(string: url)!
        var request = URLRequest(url: urlObj)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
                print("POST \(url) was successful.")
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
        return try await self.createUser(url: APIRoutes.menteePOST, jsonData: jsonData)
    }

    func createMentor(data: MentorPostData) async throws {
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw APIError.invalidRequest(
                message: "Failed to Encode Data"
            )
        }
        return try await self.createUser(url: APIRoutes.mentorPOST, jsonData: jsonData)
    }
    func getCurrentAuth() async throws -> String? {
        if let currentUser = Auth.auth().currentUser {
            do {
                let tokenResult = try await currentUser.getIDTokenResult()
                return tokenResult.token
            } catch let error {
                // Handle the error
                throw APIError.authenticationError(
                    message: "Error getting auth token: \(error.localizedDescription)"
                )
            }
        } else {
            // User is not logged in
            print("User is not logged in")
            return nil
        }
    }

    func attachTokenToRequest(request: URLRequest) async throws -> URLRequest {
        var finalRequest = request
        guard let authToken = try await getCurrentAuth() else {
            throw APIError.authenticationError(
                message: "Error getting auth token"
            )
        }
        finalRequest.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        finalRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return finalRequest
    }
    func getMentor(userID: String) async throws -> MentorGetData? {
        let urlObj = URL(string: APIRoutes.mentorGET + userID)!
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        request = try await attachTokenToRequest(request: request)
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
                print("GET \(APIRoutes.mentorGET + userID) was successful.")
                guard let mentorData = try? JSONDecoder().decode(MentorGetData.self, from: responseData) else {
                    throw APIError.invalidRequest(
                        message: "Failed to Decode Data"
                    )
                }
                return mentorData
            }
        } catch {
            print(error)
            throw error
        }
    }
    func getMentee(userID: String) async throws -> MenteeGetData? {
        let urlObj = URL(string: APIRoutes.menteeGET + userID)!
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        request = try await attachTokenToRequest(request: request)
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
                print("GET \(APIRoutes.menteeGET + userID) was successful.")
                guard let menteeData = try? JSONDecoder().decode(MenteeGetData.self, from: responseData) else {
                    throw APIError.invalidRequest(
                        message: "Failed to Decode Data"
                    )
                }
                return menteeData
            }
        } catch {
            print(error)
            throw error
        }
    }
}
