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
    
    func getMentor(userID: String) async throws -> MentorGetData? {
        let urlObj = URL(string: "http://localhost:3000/mentor/" + userID)!
        var request = URLRequest(url: urlObj)
        // swiftlint:disable:next line_length
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImM4MjNkMWE0MTg5ZjI3NThjYWI4NDQ4ZmQ0MTIwN2ViZGZhMjVlMzkiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudGVlIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MTM3MzY5OSwidXNlcl9pZCI6IjY0MzFiOTllYmNmNDQyMGZlOTgyNWZlMyIsInN1YiI6IjY0MzFiOTllYmNmNDQyMGZlOTgyNWZlMyIsImlhdCI6MTY4MTM3MzY5OSwiZXhwIjoxNjgxMzc3Mjk5LCJlbWFpbCI6Im1lbnRlZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudGVlQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.BDMmUznV2A4iG0R3Rgl0Icvh9CqbzKGDiyuvbGgus69rL9EoEzBB9BNv5t1kM0qsCjBorxG3RM8c3mlLfkESgyhC2ymPaJMPChsDq9FTBEB0PPNXe69y8oGhlKgDPhT1k3d-xXKOn5xHfqPWZk5lrQinKFiIiJ4kYHJdR-3ipjt1L5Xoa9INeUBX8YYoi_4rQe3zP11tlQgTnQrpLH8H72UmAwl-ewFKlz-jZz-AvMmROdPAx7DiTLIh-wwJGr1LsKwa13Xb0BdOMTzzwmUFgYJwnN74ivn1HH-lfkxfEyHO8UgXAF6bkaFU-2mCrwfKSMGMb3fG95GSRrujBluxuA"
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
        }
        catch {
            print(error)
            throw error
        }
    }
    
    func getMentee(userID: String) async throws -> MenteeGetData? {
        let urlObj = URL(string: "http://localhost:3000/mentee/" + userID)!
        var request = URLRequest(url: urlObj)
        // swiftlint:disable:next line_length
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImM4MjNkMWE0MTg5ZjI3NThjYWI4NDQ4ZmQ0MTIwN2ViZGZhMjVlMzkiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MTM3NDc1NSwidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MTM3NDc1NSwiZXhwIjoxNjgxMzc4MzU1LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.NqQ8aXAcr8FyA3zUilFkPzrAvHC8tMRtMwqGeYfuMNv8GKCTgOQWJrQ-yrYYrdLJ5nBjWdhoFpbEfUgb4MkjxVq9AGGCWNeoBvJZY5P0R5513p16qwNOxay3oBEwoOjkYSgaYUJ7S1PcJdBXEleb5hZK1ZeBoKEKFVeBZjcYW53P_fEPbVyIEo19krYHBgsPBaxqN_wplEijCnfEyWAwOud7FmDZZJjVDhZMN5ImMqA0HItgASrODxkl1g90YhqQwcjn40hXn9iyEzBNQKtMe-NQhj02Mzvg2Nkf4_17PicxcLEqxdoONbzZ5bY94gF-gy9MOY_J0Esip6NAxhUpJg"
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
        }
        catch {
            print(error)
            throw error
        }
    }
}
