//
//  SessionDetailViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation
import SwiftUI

final class SessionDetailViewModel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

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
        day: "Monday",
        date: "January 23, 2023",
        startTime: "9:00",
        endTime: "10:00"
    )
    @Published var formIsComplete: Bool = false
    @Published var sessionCompleted: Bool = false
    @Published var isLoading: Bool = true
    @Published var sessionID: String = ""

    func loadSession(sessionID: String) async throws {
        guard let sessionData = try? await SessionService().getSessionWithID(sessionID: sessionID) else {
            print("Error getting session info")
            return
        }

        self.sessionID = sessionID
        DispatchQueue.main.async {
            self.sessionCompleted = sessionData.session.hasPassed
        }
        if !sessionData.session.hasPassed {
            self.formIsComplete = sessionData.session.preSessionCompleted
        } else {
            if self.currentUser.role == UserRole.mentor {
                self.formIsComplete = sessionData.session.postSessionMentorCompleted
            } else {
                self.formIsComplete = sessionData.session.postSessionMenteeCompleted
            }
        }

        self.session.day = sessionData.session.day
        var startDate = SessionService().convertDate(date: sessionData.session.startTime)
        var endDate = SessionService().convertDate(date: sessionData.session.endTime)
        self.session.date = startDate[1] + "/" + startDate[2] + "/" + startDate[0]
        self.session.startTime = startDate[3] + ":" + startDate[4]
        self.session.endTime = endDate[3] + ":" + endDate[4]

        self.session.preSessionID = sessionData.session.preSession
        self.session.menteePostSessionID = sessionData.session.postSessionMentee ?? ""
        self.session.mentorPostSessionID = sessionData.session.postSessionMentor ?? ""

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
