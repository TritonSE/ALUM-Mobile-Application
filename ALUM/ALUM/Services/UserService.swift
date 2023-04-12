//
//  APIService.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/1/23.
//

import Foundation

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

struct MentorGetData: Codable {
    var menteeIDs: [String]?
    var id: String?
    var name: String
    var about: String
    var imageId: String
    var major: String
    var minor: String
    var college: String
    var career: String
    var graduationYear: Int
    var calendlyLink: String
    var topicsOfExpertise: [String]
    var mentorMotivation: String?
    var pairingIds: [String]?
    var organizationId: String?
    var personalAccessToken: String?
    var status: String?
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
    
    func getMentor(userID: String) async throws {
        let urlObj = URL(string: "http://localhost:3000/mentor/" + userID)!
        var request = URLRequest(url: urlObj)
        // swiftlint:disable:next line_length
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImM4MjNkMWE0MTg5ZjI3NThjYWI4NDQ4ZmQ0MTIwN2ViZGZhMjVlMzkiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MTMzODYxNywidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MTMzODYxNywiZXhwIjoxNjgxMzQyMjE3LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.fvRckXZTd0Ibzf4LKyJcX1uM9LT2lPZGVLzya9YemqLtrOvi3pQb4s1c96s3K4aZLrMA3_pBjXq_iaduIxHnIThw_rrtCsI4-BCB3FDXayW3TlQIfBwioTinzJgtc9gY_iiA2b1ohfZ25ohuIEYQGcNSzoXEnm1aCZKMO6OW06_zRK3L9XPpeQjpzvi-U_Y4E24nYzUVPelC-n-sHrLbfrzzywGh13f8SiSKH7m7yAflylTgFqwOwZk_qV7bvkEt8sNBQaMSA_-3baAOq0_hO8eF5lY6-cXG4MEsMGNYg-RCflU4gRyPSMiwPfei_cL2pmUKBTyxDyqNPGV5KB85sQ"
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
//            let task = try await URLSession.shared.data(from: request) { (data, response, error) in
//                if let error = error {
//                    print("HTTP Request Failed \(error)")
//                }
//                else if let data = data {
//
//                }
//            }
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
                    print("Failed to decode order")
                    return
                    }
                print(mentorData.name)
            }
        }
        catch {
            print(error)
            throw error
        }
    }
}
