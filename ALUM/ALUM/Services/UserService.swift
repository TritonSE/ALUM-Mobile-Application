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
            print("Failed to encode order")
            return
        }
        return try await self.createUser(url: "http://localhost:3000/mentee", jsonData: jsonData)
    }
    
    func createMentor(data: MentorPostData) async throws {
        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Failed to encode order")
            return
        }
        return try await self.createUser(url: "http://localhost:3000/mentor", jsonData: jsonData)
    }
    func getCurrentAuth() async throws -> String? {
        if let currentUser = Auth.auth().currentUser {
            do {
                let tokenResult = try await currentUser.getIDTokenResult()
                return tokenResult.token
            } catch let error {
                // Handle the error
                print("Error getting auth token: \(error.localizedDescription)")
                throw(error)
            }
        } else {
            // User is not logged in
            print("User is not logged in")
            return nil
        }
    }
    func getMentor(userID: String) async throws -> MentorGetData? {
        let urlObj = URL(string: "http://localhost:3000/mentor/" + userID)!
        var request = URLRequest(url: urlObj)
        guard let authToken = try await getCurrentAuth() else {
            print("Could not get auth token")
            return nil
        }
        request.httpMethod = "GET"
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
                print("GET \("http://localhost:3000/mentor/" + userID) was successful.")
                guard let mentorData = try? JSONDecoder().decode(MentorGetData.self, from: responseData) else {
                    print("Failed to decode order ")
                    return nil
                    }
                return mentorData
            }
        } catch {
            print(error)
            throw error
        }
    }
    func getMentee(userID: String) async throws -> MenteeGetData? {
        let urlObj = URL(string: "http://localhost:3000/mentee/" + userID)!
        var request = URLRequest(url: urlObj)
        let authToken = try await getCurrentAuth()
        if authToken != nil {
            print("Auth Token Identified")
        } else {
            print("Could not get auth token")
            return nil
        }
        request.httpMethod = "GET"
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
                print("GET \("http://localhost:3000/mentee/" + userID) was successful.")
                guard let menteeData = try? JSONDecoder().decode(MenteeGetData.self, from: responseData) else {
                    print("Failed to decode order ")
                    return nil
                    }
                return menteeData
            }
        } catch {
            print(error)
            throw error
        }
    }
}
