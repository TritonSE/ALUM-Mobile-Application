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

    @Published var session: SessionModel? = DevelopmentModels.sessionModel

    @Published var formIsComplete: Bool = false
    @Published var sessionCompleted: Bool = false
    @Published var isLoading: Bool = true
    @Published var sessionID: String = ""

    func fetchSession(sessionId: String) async throws {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        do {
            let sessionData = try await SessionService.shared.getSessionWithId(sessionId: sessionId)
            DispatchQueue.main.async {
                self.session = sessionData.session
                self.isLoading = false
                self.sessionCompleted = sessionData.session.hasPassed
                if self.currentUser.role == .mentee {
                    self.formIsComplete = sessionData.session.hasPassed ? sessionData.session.postSessionMenteeCompleted : sessionData.session.preSessionCompleted
                } else {
                    self.formIsComplete = sessionData.session.hasPassed ? sessionData.session.postSessionMentorCompleted : true
                }
            }
        } catch {
            print("ERROR SessionDetailViewModel.fetchSession: \(error)")
        }
    }

}
