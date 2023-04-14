//
//  SessionDetailViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    @Published var session: Session = Session()
    @Published var formIsComplete: Bool = false
    @Published var sessionCompleted: Bool = false
    
    func loadSession() async throws {
//        var sessionData: GetSessionData = try await SessionService().getSessionWithID(url: "http://localhost:3000/sessions/6436f1175a9cebd93b899a51")
        self.session.dateTime = Date()

//        var mentorRaw: MentorGetData = try await UserService().getMentor(userID: sessionData.mentorId)
        var mentor: MentorInfo = MentorInfo(
            menteeIDs: ["u123", "u1234", "abc"],
            name: "Timby Twolf",
            imageId: "34709134",
            about: "I love chocolate",
            calendlyLink: "asdasd",
            graduationYear: 2016,
            college: "UCSD",
            major: "CS",
            minor: "Business",
            career: "SWE",
            topicsOfExpertise: ["CS", "AP", "Hi"])
        
        self.session.mentor = mentor
        
//        var menteeRaw: MenteeGetData = try await UserService().getMentee(userID: sessionData.menteeId)
        var mentee: MenteeInfo = MenteeInfo(
            id: "u123",
            name: "Timby Twolf",
            imageId: "23462",
            about: "I love caramel",
            grade: 10,
            topicsOfInterest: ["AP", "CS"],
            careerInterests: ["SWE"]);
        self.session.mentee = mentee
    }
}
