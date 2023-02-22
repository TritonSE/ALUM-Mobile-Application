//
//  SignUpConfirmationViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/21/23.
//

import Foundation
import SwiftUI

final class SignUpConfirmationViewModel: ObservableObject {
    @Published var mentee = Mentee(name: "John Doe", email: "jdoe@iusd.com", grade: "10", mentorshipGoal: "I want to learn computer science and build apps with my mentor", password: "a123")
    func submitSignUp() {
        let apiService = ApiService()
        let postData = PostData(name: mentee.name, email: mentee.email, password: mentee.password, grade: mentee.grade, mentorshipGoal: mentee.mentorshipGoal)
        apiService.postData(data: postData, isMentor: false)
    }
}
