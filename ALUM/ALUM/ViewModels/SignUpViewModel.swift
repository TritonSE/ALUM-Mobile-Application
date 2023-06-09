//
//  SignUpViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/5/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import SwiftUI

final class SignUpViewModel: ObservableObject {
    @Published var passwordAgain: String = ""
    @Published var emailFunc: [(String) -> (Bool, String)] = []
    @Published var passFunc: [(String) -> (Bool, String)] = []
    @Published var passAgainFunc: [(String) -> (Bool, String)] = []
    @Published var isMentee = false
    @Published var isMentor = false
    @Published var setUpIsInvalid = false
    @Published var submitSuccess = false

    @Published var account = Account(name: "", email: "", password: "")
    @Published var mentee = Mentee()
    @Published var mentor = Mentor()

    func setUpMentee() {
        submitSuccess = false
        mentee.name = account.name
        mentee.email = account.email
        mentee.password = account.password
    }

    func setUpMentor() {
        submitSuccess = false
        mentor.name = account.name
        mentor.email = account.email
        mentor.password = account.password
    }

    func checkPasswordSame() {
        if !(self.account.password == self.passwordAgain) {
            self.passAgainFunc = [ErrorFunctions.passNotSame]
        } else {
            self.passAgainFunc = []
        }
    }

    func submitMenteeSignUp() async throws {
        let menteeData = MenteePostData(
            name: mentee.name,
            email: mentee.email,
            password: mentee.password,
            grade: mentee.grade,
            topicsOfInterest: mentee.topicsOfInterest,
            careerInterests: mentee.careerInterests,
            mentorshipGoal: mentee.mentorshipGoal
        )
        try await UserService().createMentee(data: menteeData)
    }

    func submitMentorSignUp() async throws {
        let mentorData = MentorPostData(
            name: mentor.name,
            email: mentor.email,
            password: mentor.password,
            graduationYear: mentor.yearOfGrad,
            college: mentor.university,
            major: mentor.major,
            minor: mentor.minor,
            career: mentor.intendedCareer,
            topicsOfExpertise: mentor.topicsOfExpertise,
            mentorMotivation: mentor.mentorMotivation,
            location: mentor.location,
            calendlyLink: mentor.calendlyLink
        )
        try await UserService.shared.createMentor(data: mentorData)
    }
}
