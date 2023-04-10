//
//  MenteeProfileViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import Foundation
import SwiftUI

final class MenteeProfileViewmodel: ObservableObject {
    @Published var mentee = MenteeProfile(
        name: "Timby Twolf",
        email: "tbtwolf@gmail.com",
        grade: "9",
        topicsOfInterest: ["AP Classes", "Interest 2"],
        careerInterests: ["Career1", "Career2"],
        mentorshipGoal: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """,
        profilePic: Image("ALUMLogoBlue"),
        mentor: "u3491237981"
    )

    @Published var selfView = true
}
