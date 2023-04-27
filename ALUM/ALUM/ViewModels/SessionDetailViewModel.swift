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
        menteePostSessionID: "xyz789",
        mentorPostSessionID: "zyx987",
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
    @Published var isLoading: Bool = true

    func loadSession(sessionID: String) async throws {
        guard let sessionData = try? await SessionService().getSessionWithID(sessionID: sessionID) else {
            print("Error getting session info")
            return
        }
        self.session.dateTime = sessionData.session.dateTime
        self.session.preSessionID = sessionData.session.preSession
        self.session.menteePostSessionID = sessionData.session.postSessionMentee
        self.session.mentorPostSessionID = sessionData.session.postSessionMentor

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
        self.isLoading = false
    }
}
