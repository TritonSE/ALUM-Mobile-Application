//
//  SessionService.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

struct SessionInfo: Decodable {
    var preSession: String
    var postSession: String
    var menteeId: String
    var mentorId: String
    var dateTime: String
}

struct GetSessionData: Decodable {
    var message: String
    var session: SessionInfo
}

class SessionService {
    func getSessionWithID(sessionID: String) async throws -> GetSessionData? {
        let urlObj = URL(string: "http://localhost:3000/sessions/" + sessionID)!
        var request = URLRequest(url: urlObj)
        /*
        guard let authToken = try await UserService().getCurrentAuth() else {
            print("Could not get auth token")
            throw APIError.invalidRequest(message: "Could not get auth token")
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
                print("GET \("http://localhost:3000/sessions/" + sessionID) was successful.")
                guard let sessionData = try? JSONDecoder().decode(GetSessionData.self, from: responseData) else {
                    print("Failed to decode data")
                    throw APIError.invalidRequest(message: "Could not decode data")
                }
                return sessionData
            }
        } catch {
            print(error)
            throw error
        }
    }
}
