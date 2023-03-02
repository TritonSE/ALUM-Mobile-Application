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
    var grade: String
    var topicsOfInterest: [String]
    var careerInterests: [String]
    var mentorshipGoal: String
}

struct MentorPostData: Codable {
    var name: String
    var email: String
    var password: String
    var graduationYear: String
    var college: String
    var major: String
    var minor: String
    var career: String
    var topicsOfExpertise: [String]
    var mentorMotivation: String
    var organizationId: String
    var personalAccessToken: String
}

class ApiService {
    func postMenteeData(data: MenteePostData) async {

        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "localhost:3000/mentee")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (postedData, _) = try await URLSession.shared.upload(for: request, from: jsonData)
            let decodedData = try JSONDecoder().decode(MenteePostData.self, from: postedData)
            let confirmationMessage = "\(decodedData.name), you have succesfully signed up with the email \(decodedData.email)!"
            print(confirmationMessage)
        } catch {
            print("POST failed.")
        }
    }
    func postMentorData(data: MentorPostData) async {

        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "localhost:3000/mentor")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (postedData, _) = try await URLSession.shared.upload(for: request, from: jsonData)
            let decodedData = try JSONDecoder().decode(MentorPostData.self, from: postedData)
            let confirmationMessage = "\(decodedData.name), you have succesfully signed up with the email \(decodedData.email)!"
            print(confirmationMessage)
        } catch {
            print("POST failed.")
        }
    }
}
