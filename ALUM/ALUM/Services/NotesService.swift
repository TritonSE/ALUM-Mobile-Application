//
//  NotesService.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/10/23.
//

import Foundation

enum PatchAnswer: Codable {
    case string(String)
    case listString([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let listString = try? container.decode([String].self) {
            self = .listString(listString)
        } else {
            throw DecodingError.typeMismatch(PatchAnswer.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid type for PatchAnswer"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .listString(let values):
            try container.encode(values)
        }
    }
}

struct QuestionPatchData: Codable {
    var answer: PatchAnswer
    var type: String
    var id: String
}

class NotesService {
    func patchNotes(url: String, jsonData: Data) async throws {
        let urlObj = URL(string: url)!
        var request = URLRequest(url: urlObj)

        request.httpMethod = "PATCH"
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
                print("PATCH \(url) was successful.")
            }
        } catch {
            print(error)
            throw error
        }
    }

    func patchNotesHelper(data: [QuestionPatchData]) async throws {
        guard let jsonData = try? JSONEncoder().encode(data) else {
           print("Failed to encode order")
           return
        }
        // need to add
        return try await self.patchNotes(url: "http://localhost:3000/notes", jsonData: jsonData)
    }
}
