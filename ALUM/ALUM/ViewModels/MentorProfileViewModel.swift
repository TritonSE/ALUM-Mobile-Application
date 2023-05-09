//
//  MentorProfileViewmodel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/7/23.
//

import Foundation
import SwiftUI

final class MentorProfileViewModel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModal = CurrentUserModal.shared

    @Published var mentor: MentorInfo?
    @Published var selfView: Bool?

    func fetchMentorInfo(userID: String) async throws {
        do {
            let mentorData = try await UserService.shared.getMentor(userID: userID)

            DispatchQueue.main.async {
                self.mentor = mentorData.mentor
                self.selfView = self.currentUser.uid == mentorData.mentor.id
            }
        } catch {
            print("An error occurred: \(error.localizedDescription)")
        }
    }

    func isLoading() -> Bool {
        return mentor == nil || selfView == nil
    }
}
