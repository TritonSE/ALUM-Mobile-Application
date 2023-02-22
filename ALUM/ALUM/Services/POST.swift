//
//  POST.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/20/23.
//

import Foundation

struct PostData: Codable {
    let name: String
    let email: String
    let password: String
    let grade: String
//    let topicsOfInterest: [String]
//    let careerInterests: [String]
    let mentorshipGoal: String
}

class ApiService {
    func postData(data: PostData, isMentor: Bool) {
        var urlString: String
        if isMentor {
            urlString = "localhost:3000/mentor"
        }
        else{
            urlString = "localhost:3000/mentee"
        }
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(data)
            request.httpBody = jsonData
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error making POST request: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(PostData.self, from: data)
                    print("Response received: \(response)")
                } catch {
                    print("Error decoding response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
