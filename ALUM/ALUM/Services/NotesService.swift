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
            throw DecodingError.typeMismatch(PatchAnswer.self,
                                             DecodingError.Context(codingPath: decoder.codingPath,
                                                                   debugDescription: "Invalid type for PatchAnswer"))
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

    func toRaw(question: inout Question) {
        switch self {
        case .string(let value):
            question.answerParagraph = value
        case .listString(let values):
            question.answerBullet = values
        }
    }
}

struct QuestionPatchData: Codable {
    var answer: PatchAnswer
    var type: String
    var questionId: String
}

struct QuestionGetData: Identifiable, Decodable {
    var answer: PatchAnswer
    var type: String
    var id: String
    var question: String
}

class NotesService {
    static let shared = NotesService()

    func patchNotes(noteId: String, data: [QuestionPatchData]) async throws {
        print(data.count)
        let route = APIRoute.patchNote(noteId: noteId)
        var request = try await route.createURLRequest()
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw AppError.internalError(.jsonParsingError, message: "Failed to Encode Data")
        }
        request.httpBody = jsonData
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        print("SUCCESS - \(route.label)")
    }

    func getNotes(noteId: String) async throws -> [QuestionGetData] {
        let route = APIRoute.getNote(noteId: noteId)
        let request = try await route.createURLRequest()
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)

        do {
            let notesData = try JSONDecoder().decode([QuestionGetData].self, from: responseData)
            print("SUCCESS - \(route.label)")
            return notesData
        } catch {
            print("Failed to decode data")
            throw AppError.internalError(.jsonParsingError, message: "Failed to Decode Data")
        }
    }
}
