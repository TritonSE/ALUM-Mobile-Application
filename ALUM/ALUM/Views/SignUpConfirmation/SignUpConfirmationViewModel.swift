//
//  SignUpConfirmationViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/21/23.
//

import Foundation
import SwiftUI

let topics = [TagDisplay(text: "College Applications"), TagDisplay(text: "AP Classes"), TagDisplay(text: "Summer Courses")]
let career = [TagDisplay(text: "Statistics")]
let mentorship = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation"

final class SignUpConfirmationViewModel: ObservableObject {
    @Published var mentee = Mentee(name: "John Doe", email: "jdoe@iusd.com", grade: "10", topicsOfInterest: topics, careerInterests: career, mentorshipGoal: mentorship, password: "a123")
    var topicString: [String] = []
    var careerString: [String] = []
    func submitSignUp() {
        for topic in mentee.topicsOfInterest {
            topicString.append(topic.text)
        }
        for topic in mentee.careerInterests {
            careerString.append(topic.text)
        }
        let apiService = ApiService()
        let postData = PostData(name: mentee.name, email: mentee.email, password: mentee.password, grade: mentee.grade, topics: topicString, careers: careerString, mentorship: mentee.mentorshipGoal)
        apiService.postData(data: postData, isMentor: false)
    }
}
