//
//  MenteeProfileViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import Foundation
import SwiftUI

final class MenteeProfileViewmodel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    @Published var mentee: MenteeInfo? = DevelopmentModels.menteeModel
    @Published var selfView: Bool?

    func fetchMenteeInfo(userID: String) async throws {
        guard let menteeData = try? await UserService.shared.getMentee(userID: userID) else {
            print("Error getting info")
            return
        }

        DispatchQueue.main.async {
            self.mentee = menteeData.mentee
            self.selfView = self.currentUser.uid == menteeData.mentee.id
        }
    }

    func updateMenteeInfo() async throws {
        let mentee = self.mentee!
        let updatedMentee = MenteePatchData(name: mentee.name,
                                            imageId: mentee.imageId,
                                            about: mentee.about,
                                            grade: mentee.grade,
                                            topicsOfInterest: mentee.topicsOfInterest,
                                            careerInterests: mentee.careerInterests,
                                            mentorshipGoal: mentee.mentorshipGoal ?? "")
        try await UserService.shared.patchMentee(userID: mentee.id, data: updatedMentee)
        try await fetchMenteeInfo(userID: mentee.id)
    }

    func isLoading() -> Bool {
        return mentee == nil || selfView == nil
    }
}
