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
        /*
        guard let authToken = try await getCurrentAuth() else {
            print("Could not get auth token")
            return nil
        }
        */
        let authToken =
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZGE4NmU4MWJkNTllMGE4Y2YzNTgwNTJiYjUzYjUzYjE4MzA3NzMiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoia" +
        "HR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MjA1ODczOCwidXNlcl9pZ" +
        "CI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MjA1ODczOCwiZXhwIjoxNjgyMDYyMzM4LCJlbWFpb" +
        "CI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic" +
        "2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.JVc7hWZzJ6niqg-KgDj17vG_rLDi2_lnXPHKAMInS3o0yTtjC6LkKVFMxDKbgkv5fxTyTxMm3EGxq8Ur150CrP9f66jD-Yfb" +
        "RtqQpddRwOR0kBHFZr1ayXTIEMu6epugTCrEHX6rRo-TZUm3moI2_4avPVGpLpDl-gmwBDa6co_JOhAGGNoOxif68lG50j6e12SSeWoglkcpKoVOwYjtN2WVSVV9pg6Nmuy8VwFU" +
        "0gSbwpnrI6nF0eFBxUbynjsGKf56DBm9Pl510NMs0HkBxsHFC8Rbfpr4iHuTohBELgM0OiG3i2IeuTIbED5hbL_3yQqkKBEociV7GEyZDmVV2g"
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
        /*
        guard let authToken = try await getCurrentAuth() else {
            print("Could not get auth token")
            return nil
        }
         */
        let authToken =
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZGE4NmU4MWJkNTllMGE4Y2YzNTgwNTJiYjUzYjUzYjE4MzA3NzMiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoia" +
        "HR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MjA1ODczOCwidXNlcl9pZ" +
        "CI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MjA1ODczOCwiZXhwIjoxNjgyMDYyMzM4LCJlbWFpb" +
        "CI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic" +
        "2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.JVc7hWZzJ6niqg-KgDj17vG_rLDi2_lnXPHKAMInS3o0yTtjC6LkKVFMxDKbgkv5fxTyTxMm3EGxq8Ur150CrP9f66jD-Yfb" +
        "RtqQpddRwOR0kBHFZr1ayXTIEMu6epugTCrEHX6rRo-TZUm3moI2_4avPVGpLpDl-gmwBDa6co_JOhAGGNoOxif68lG50j6e12SSeWoglkcpKoVOwYjtN2WVSVV9pg6Nmuy8VwFU" +
        "0gSbwpnrI6nF0eFBxUbynjsGKf56DBm9Pl510NMs0HkBxsHFC8Rbfpr4iHuTohBELgM0OiG3i2IeuTIbED5hbL_3yQqkKBEociV7GEyZDmVV2g"
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
