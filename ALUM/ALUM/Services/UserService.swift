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

struct MentorGetData: Decodable {
    var message: String
    var mentor: MentorInfo
    var whyPaired: String?
}

struct MentorInfo: Decodable {
    var menteeIDs: [String]?
    var id: String?
    var name: String
    var imageId: String
    var about: String
    var calendlyLink: String
    var zoomLink: String
    var graduationYear: Int
    var college: String
    var major: String
    var minor: String
    var career: String
    var topicsOfExpertise: [String]
    var mentorMotivation: String?
    var pairingIds: [String]?
    var organizationId: String?
    var personalAccessToken: String?
    var status: String?
    var mongoVersion: Int?
    var whyPaired: String?

    private enum CodingKeys: String, CodingKey {
        case menteeIDs
        case id = "_id"
        case name
        case imageId
        case about
        case calendlyLink
        case zoomLink
        case graduationYear
        case college
        case major
        case minor
        case career
        case topicsOfExpertise
        case mentorMotivation
        case pairingIds
        case organizationId
        case personalAccessToken
        case status
        case mongoVersion = "__v"
        case whyPaired
    }
    
    init(name: String = "", imageId: String = "", about: String = "", calendlyLink: String = "",
         zoomLink: String = "", graduationYear: Int = 0, college: String = "", major: String = "",
         minor: String = "", career: String = "", topicsOfExpertise: [String] = []) {
        self.name = name
        self.imageId = imageId
        self.about = about
        self.calendlyLink = calendlyLink
        self.zoomLink = zoomLink
        self.graduationYear = graduationYear
        self.college = college
        self.major = major
        self.minor = minor
        self.career = career
        self.topicsOfExpertise = topicsOfExpertise
    }
}

struct MenteeGetData: Decodable {
    var message: String
    var mentee: MenteeInfo
    var whyPaired: String?
}

struct MenteeInfo: Decodable {
    var id: String?
    var name: String
    var imageId: String
    var about: String
    var grade: Int
    var topicsOfInterest: [String]
    var careerInterests: [String]
    var mentorshipGoal: String?
    var pairingId: String?
    var status: String?
    var mongoVersion: Int?
    var whyPaired: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case imageId
        case about
        case grade
        case topicsOfInterest
        case careerInterests
        case mentorshipGoal
        case pairingId
        case status
        case mongoVersion = "__v"
        case whyPaired
    }
    
    init(name: String = "", imageId: String = "", about: String = "", grade: Int = 0,
         topicsOfInterest: [String] = [], careerInterests: [String] = []) {
        self.name = name
        self.imageId = imageId
        self.about = about
        self.grade = grade
        self.topicsOfInterest = topicsOfInterest
        self.careerInterests = careerInterests
    }
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

    func getMentor(userID: String) async throws -> MentorGetData {
        let urlObj = URL(string: "http://localhost:3000/mentor/" + userID)!
        var request = URLRequest(url: urlObj)
        guard let authToken = try await getCurrentAuth() else {
            print("Could not get auth token")
            throw APIError.invalidRequest(message: "Could not get auth token")
        }
        print(authToken)
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
                guard let mentorData = try? JSONDecoder().decode(MentorGetData.self, from: responseData) as? MentorGetData else {
                    print("Failed to decode order ")
                    throw APIError.invalidRequest(message: "Could not decode data")
                }
                return mentorData
            }
        } catch {
            print(error)
            throw error
        }
    }

    func getMentee(userID: String) async throws -> MenteeGetData {
        let urlObj = URL(string: "http://localhost:3000/mentee/" + userID)!
        var request = URLRequest(url: urlObj)
        let authToken = try await getCurrentAuth()
        if authToken != nil {
            print("Auth Token Identified")
        } else {
            print("Could not get auth token")
            throw APIError.invalidRequest(message: "Could not get auth token")
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
                guard let menteeData = try? JSONDecoder().decode(MenteeGetData.self, from: responseData) as? MenteeGetData else {
                    print("Failed to decode order ")
                    throw APIError.invalidRequest(message: "Could not decode data")
                }
                return menteeData
            }
        } catch {
            print(error)
            throw error
        }
    }
}
