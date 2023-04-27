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
    
    func getMentor(userID: String) async throws -> MentorGetData? {
        let urlObj = URL(string: "http://localhost:3000/mentor/" + userID)!
        var request = URLRequest(url: urlObj)
        /*
        guard let authToken = try await getCurrentAuth() else {
            print("Could not get auth token")
            return nil
        }
        */
        // swiftlint:disable:next line_length
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImU3OTMwMjdkYWI0YzcwNmQ2ODg0NGI4MDk2ZTBlYzQzMjYyMjIwMDAiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MjU1OTA3NywidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MjU1OTA3NywiZXhwIjoxNjgyNTYyNjc3LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.JC1Xygx5uYt381ogRhlVoZrzwVBGPUna4R7enlci2noU2YVD_NUxA4lPGJGC52mt7H7BciGuBbtblLfx_f9EwUOjVrwdpdaRbjRDKybYzb97ajXRznBElNXrSMwHtbv00cPZi1C8eCcn_ILtGhmw_0HokSERjz8yzRKsHxTn5gaUgOKyqwj2r1amI1Km10E4yH7bjJXHpMiab8idkG9CbyU8SQUiCEilqj2ADWEhHNPc1MD2m8ccri4GM6Ww351xUPKkJGHxZMHNCYS5Z3naoia8myhdKZRkaz3TLeWMyFl_Z9nsjmINytyFtVRe_Bro4NZqMkl07XUaGe0dtMdWFA"
        request.httpMethod = "GET"
        // request = try await attachTokenToRequest(request: request)
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
                guard let mentorData = try? JSONDecoder().decode(MentorGetData.self, from: responseData) else {
                    throw APIError.invalidRequest(
                        message: "Failed to Decode Data"
                    )
                }
                print("GET \(APIRoutes.mentorGET + userID) was successful.")
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
        // swiftlint:disable:next line_length
        let authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImU3OTMwMjdkYWI0YzcwNmQ2ODg0NGI4MDk2ZTBlYzQzMjYyMjIwMDAiLCJ0eXAiOiJKV1QifQ.eyJyb2xlIjoibWVudG9yIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FsdW0tbW9iaWxlLWFwcCIsImF1ZCI6ImFsdW0tbW9iaWxlLWFwcCIsImF1dGhfdGltZSI6MTY4MjU1OTA3NywidXNlcl9pZCI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsInN1YiI6IjY0MzFiOWEyYmNmNDQyMGZlOTgyNWZlNSIsImlhdCI6MTY4MjU1OTA3NywiZXhwIjoxNjgyNTYyNjc3LCJlbWFpbCI6Im1lbnRvckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWVudG9yQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.JC1Xygx5uYt381ogRhlVoZrzwVBGPUna4R7enlci2noU2YVD_NUxA4lPGJGC52mt7H7BciGuBbtblLfx_f9EwUOjVrwdpdaRbjRDKybYzb97ajXRznBElNXrSMwHtbv00cPZi1C8eCcn_ILtGhmw_0HokSERjz8yzRKsHxTn5gaUgOKyqwj2r1amI1Km10E4yH7bjJXHpMiab8idkG9CbyU8SQUiCEilqj2ADWEhHNPc1MD2m8ccri4GM6Ww351xUPKkJGHxZMHNCYS5Z3naoia8myhdKZRkaz3TLeWMyFl_Z9nsjmINytyFtVRe_Bro4NZqMkl07XUaGe0dtMdWFA"
        request.httpMethod = "GET"
        // request = try await attachTokenToRequest(request: request)
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
                guard let menteeData = try? JSONDecoder().decode(MenteeGetData.self, from: responseData) else {
                    throw APIError.invalidRequest(
                        message: "Failed to Decode Data"
                    )
                }
                print("GET \(APIRoutes.menteeGET + userID) was successful.")
                return menteeData
            }
        } catch {
            print(error)
            throw error
        }
    }
}
