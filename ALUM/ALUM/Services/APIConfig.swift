//
//  APIConfig.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/1/23.
//

import Foundation

let baseURL: String = "http://localhost:3000"
struct URLString {
    static let user = "\(baseURL)/user"
    static let mentor = "\(baseURL)/mentor"
    static let mentee = "\(baseURL)/mentee"
    static let notes = "\(baseURL)/notes"
    static let sessions = "\(baseURL)/sessions"
    static let calendly = "\(baseURL)/calendly"
}

enum APIRoute {
    case getSelf
    case getMentor(userId: String)
    case getMentee(userId: String)
    case postMentor
    case postMentee
    case patchMentor(userId: String)
    case patchMentee(userId: String)
    case getCalendly

    case getNote(noteId: String)
    case patchNote(noteId: String)

    case getSession(sessionId: String)
    case getSessions
    case postSession
    case patchSession(sessionId: String)
    case deleteSession(sessionId: String)

    var url: String {
        switch self {
        case .getSelf:
            return [URLString.user, "me"].joined(separator: "/")
        case .getMentor(let userId):
            return [URLString.mentor, userId].joined(separator: "/")
        case .getMentee(let userId):
            return [URLString.mentee, userId].joined(separator: "/")
        case .postMentor:
            return URLString.mentor
        case .postMentee:
            return URLString.mentee
        case .patchMentor(let userId):
            return [URLString.mentor, userId].joined(separator: "/")
        case .patchMentee(let userId):
            return [URLString.mentee, userId].joined(separator: "/")
        case .getNote(noteId: let noteId):
            return [URLString.notes, noteId].joined(separator: "/")
        case .patchNote(noteId: let noteId):
            return [URLString.notes, noteId].joined(separator: "/")
        case .getSession(sessionId: let sessionId):
            return [URLString.sessions, sessionId].joined(separator: "/")
        case .getSessions:
            return URLString.sessions
        case .postSession:
            return URLString.sessions
        case .deleteSession(sessionId: let sessionId):
            return [URLString.sessions, sessionId].joined(separator: "/")
        case .patchSession(sessionId: let sessionId):
            return [URLString.sessions, sessionId].joined(separator: "/")
        case .getCalendly:
            return URLString.calendly
        }
    }

        var method: String {
            switch self {
            case .getSelf, .getMentee, .getMentor, .getNote, .getSession, .getSessions, .getCalendly:
                return "GET"
            case .postMentor, .postMentee, .postSession:
                return "POST"
            case .deleteSession:
                return "DELETE"
            case .patchNote, .patchSession, .patchMentor, .patchMentee:
                return "PATCH"
            }
        }

        var requireAuth: Bool {
            switch self {
            case .getSelf, .getMentor, .getMentee, .getNote, .patchNote, .getSession,
                    .getSessions, .postSession, .getCalendly, .deleteSession,
                    .patchSession, .patchMentor, .patchMentee:
                return true
            case .postMentee, .postMentor:
                return false
            }
        }

        func createURLRequest() async throws -> URLRequest {
            return try await ServiceHelper.shared.createRequest(
                urlString: self.url,
                method: self.method,
                requireAuth: self.requireAuth
            )
        }

        var label: String {
            return "\(self.method) \(self.url)"
        }

        var successCode: Int {
            switch self {
            case .getSelf, .getMentor, .getMentee, .getNote, .patchNote,
                    .getSession, .getSessions, .getCalendly,
                    .deleteSession, .patchSession, .patchMentor, .patchMentee:
                return 200 // 200 Ok
            case .postMentor, .postMentee, .postSession:
                return 201 // 201 Created
            }
        }

        func getAppError(statusCode: Int, message: String) -> AppError {
            let labeledMessage = "\(self.label) - \(message)"
            let errorMap: [Int: AppError]

            switch self {
            case .getSelf, .getMentor, .getMentee, .getNote, .patchNote,
                    .getSession, .getSessions, .getCalendly,
                    .deleteSession, .patchSession, .patchMentor, .patchMentee:
                errorMap = [
                    401: AppError.actionable(.authenticationError, message: labeledMessage),
                    400: AppError.internalError(.invalidRequest, message: labeledMessage),
                    404: AppError.internalError(.invalidRequest, message: labeledMessage)
                ]
            case  .postSession:
                errorMap = [
                    400: AppError.internalError(.invalidRequest, message: labeledMessage)
                ]
            case .postMentor, .postMentee:
                // message will be displayed to user so no label here
                errorMap = [
                    400: AppError.actionable(.invalidInput, message: message)
                ]
            }

            let error = errorMap[statusCode] ?? AppError.internalError(.unknownError, message: labeledMessage)
            return error
        }
}
