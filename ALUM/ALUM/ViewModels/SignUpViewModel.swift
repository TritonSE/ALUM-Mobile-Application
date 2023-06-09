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
    @Published var isSubmitting = false
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

    func isMentorStep3Complete() -> Bool {
        return mentor.yearOfGrad != 0 &&
            mentor.university != "" &&
            mentor.major != "" &&
            mentor.minor != "" &&
            mentor.intendedCareer != "" &&
            mentor.location != "" &&
            mentor.calendlyLink != "" &&
            mentor.personalAccessToken != "" &&
            mentor.mentorMotivation != "" &&
            !mentor.topicsOfExpertise.isEmpty
    }

    func isMenteeStep3Complete() -> Bool {
        return mentee.grade != 0 &&
        !mentee.topicsOfInterest.isEmpty &&
        !mentee.careerInterests.isEmpty &&
        mentee.mentorshipGoal != ""
    }

    func submitMenteeSignUp() async {
        DispatchQueue.main.async {
            self.isSubmitting = true
        }
        let menteeData = MenteePostData(
            name: mentee.name,
            email: mentee.email,
            password: mentee.password,
            grade: mentee.grade,
            topicsOfInterest: mentee.topicsOfInterest,
            careerInterests: mentee.careerInterests,
            mentorshipGoal: mentee.mentorshipGoal
        )
        do {
           try await UserService.shared.createMentee(data: menteeData)
            DispatchQueue.main.async {
                self.submitSuccess = true
                self.isSubmitting = false
            }
       } catch let error as AppError {
           switch error {
           case .actionable(.invalidInput, let message):
               DispatchQueue.main.async {
                   CurrentUserModel.shared.errorMessage = message
                   CurrentUserModel.shared.showInternalError = true
                   self.isSubmitting = false
               }
           default:
               break
           }
       } catch {}
    }

    func submitMentorSignUp() async {
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
            calendlyLink: mentor.calendlyLink,
            personalAccessToken: mentor.personalAccessToken
        )

        do {
           try await UserService.shared.createMentor(data: mentorData)
            DispatchQueue.main.async {
                self.submitSuccess = true
            }
       } catch let error as AppError {
           switch error {
           case .actionable(.invalidInput, let message):
               DispatchQueue.main.async {
                   CurrentUserModel.shared.errorMessage = message
                   CurrentUserModel.shared.showInternalError = true
               }
           default:
               break
           }
       } catch {}
    }
}
