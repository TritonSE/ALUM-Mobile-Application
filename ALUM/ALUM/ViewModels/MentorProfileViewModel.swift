//
//  MentorProfileViewmodel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/7/23.
//

import Foundation
import SwiftUI

final class MentorProfileViewModel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

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
            print("An error occurred: \(error)")
        }
    }

    func updateMentorInfo() async throws {
        let mentor = self.mentor!
        let updatedMentor = MentorPatchData(name: mentor.name,
                                            imageId: mentor.imageId,
                                            about: mentor.about,
                                            calendlyLink: mentor.calendlyLink,
                                            /// only update token if it was changed
                                            personalAccessToken:
                                                mentor.personalAccessToken != "[REDACTED]" ?
                                                    mentor.personalAccessToken : nil,
                                            graduationYear: mentor.graduationYear,
                                            college: mentor.college,
                                            major: mentor.major,
                                            minor: mentor.minor,
                                            career: mentor.career,
                                            topicsOfExpertise: mentor.topicsOfExpertise,
                                            mentorMotivation: mentor.mentorMotivation ?? "",
                                            location: mentor.zoomLink ?? "")
        try await UserService.shared.patchMentor(userID: mentor.id, data: updatedMentor)
        try await fetchMentorInfo(userID: mentor.id)
    }

    func isLoading() -> Bool {
        return mentor == nil || selfView == nil
    }
}
