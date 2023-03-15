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

    @Published var account = Account(name: "", email: "", password: "")
    @Published var mentee = Mentee(name: "", email: "", grade: "", topicsOfInterest: [], careerInterests: [],
                                   mentorshipGoal: "", password: "")
    @Published var mentor = Mentor(name: "", email: "", yearOfGrad: "", university: "", major: "", minor: "",
                                   intendedCareer: "", whyMentor: "", topicsOfExpertise: [], password: "")

    func setUpMentee() {
        mentee.name = account.name
        mentee.email = account.email
        mentee.password = account.password
    }

    func setUpMentor() {
        mentor.name = account.name
        mentor.email = account.email
        mentor.password = account.password
    }

    func checkPasswordSame() {
        if !(self.account.password == self.passwordAgain) {
            self.passAgainFunc = [SignUpFlowErrorFunctions.passNotSame]
        } else {
            self.passAgainFunc = []
        }
    }
}
