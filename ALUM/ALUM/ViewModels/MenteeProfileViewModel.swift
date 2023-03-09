//
//  MenteeProfileViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import Foundation
import SwiftUI

final class MenteeProfileViewmodel: ObservableObject {
    // swiftlint:disable:next line_length
    @Published var mentee = MenteeProfile(name: "Timby Twolf", email: "tbtwolf@gmail.com", grade: "9", topicsOfInterest: topics, careerInterests: career, mentorshipGoal: "I want to learn", profilePic: Image("ALUMLogoBlue"), mentor: "u3491237981")
}
