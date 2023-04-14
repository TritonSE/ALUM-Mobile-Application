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
        do {
            var sessionData: GetSessionData = try await SessionService().getSessionWithID(url: "http://localhost:3000/sessions/6436f1175a9cebd93b899a51")
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
    }
}
