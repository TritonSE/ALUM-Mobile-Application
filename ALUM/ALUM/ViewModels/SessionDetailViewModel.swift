//
//  SessionDetailViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    @Published var session = Session(
        preSessionID: "abc123",
        postSessionID: "xyz789",
        mentor: MentorGetData(
            message: "Hello",
            mentor: MentorInfo(
                id: "123",
                name: "Timby Twolf",
                imageId: "34709134",
                about: "I love chocolate",
                calendlyLink: "asdasd",
                zoomLink: "zoom.com",
                graduationYear: 2016,
                college: "UCSD",
                major: "CS",
                minor: "Business",
                career: "SWE",
                topicsOfExpertise: ["CS", "AP", "Hi"]
            )
        ),
        mentee: MenteeGetData(
            message: "Hello",
            mentee: MenteeInfo(
                id: "u123",
                name: "Timby Twolf",
                imageId: "23462",
                about: "I love caramel",
                grade: 10,
                topicsOfInterest: ["AP", "CS"],
                careerInterests: ["SWE"]
            )
        ),
        dateTime: "June 10, 2023"
    )
    @Published var formIsComplete: Bool = false
    @Published var sessionCompleted: Bool = false
    
    init() {
        Task {
            do {
                try await self.loadSession(sessionID: "6436f55ad2548e9e6503bf7f")
            } catch {
                print(error)
            }
        }
    }
    
    func loadSession(sessionID: String) async throws {
        guard let sessionData = try? await SessionService().getSessionWithID(sessionID: sessionID) else {
            print("Error getting session info")
            return
        }
        self.session.dateTime = sessionData.session.dateTime
        self.session.preSessionID = sessionData.session.preSession
        self.session.postSessionID = sessionData.session.postSession
        
        guard let mentorData = try? await UserService().getMentor(userID: sessionData.session.mentorId) else {
            print("Error getting mentor info")
            return
        }
        self.session.mentor = mentorData
        
        guard let menteeData = try? await UserService().getMentee(userID: sessionData.session.menteeId) else {
            print("Error getting mentee info")
            return
        }
        self.session.mentee = menteeData
        
        /*
        do {
            var sessionData: GetSessionData = try await SessionService().getSessionWithID(sessionID: "6436f1175a9cebd93b899a51")
            self.session.dateTime = sessionData.session.dateTime

            var mentorRaw: MentorGetData = try await UserService().getMentor(userID: sessionData.session.mentorId)
            var mentor: MentorInfo = mentorRaw.mentor
            self.session.mentor = mentor

            var menteeRaw: MenteeGetData = try await UserService().getMentee(userID: sessionData.session.menteeId)
            var mentee: MenteeInfo = menteeRaw.mentee
            self.session.mentee = mentee
        } catch {
            print(error)
            throw(error)
        }
         */
    }
}
