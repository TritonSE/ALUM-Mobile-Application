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
    // swiftlint:disable:next line_length
    @Published var mentor = Mentor(name: "Jill Doe", email: "jill@gmail.com", yearOfGrad: "2016", university: "UCSD", major: "CS", minor: "N/A", intendedCareer: "SWE", topicsOfExpertise: topics, mentorMotivation: "I love teaching", organizationId: "TSE", personalAccessToken: "123", password: "b123")
    func submitMenteeSignUp() async {
        // converts tag objects into strings
        var topicString: [String] = []
        var careerString: [String] = []
        for topic in mentee.topicsOfInterest {
            topicString.append(topic.text)
        }
        for topic in mentee.careerInterests {
            careerString.append(topic.text)
        }
        let apiService = ApiService()
        // swiftlint:disable:next line_length
        let postData = MenteePostData(name: mentee.name, email: mentee.email, password: mentee.password, grade: mentee.grade, topicsOfInterest: topicString, careerInterests: careerString, mentorshipGoal: mentee.mentorshipGoal)
        await apiService.postMenteeData(data: postData)
    }
    func submitMentorSignUp() async {
        // converts tag objects into strings
        var topicString: [String] = []
        for topic in mentee.topicsOfInterest {
            topicString.append(topic.text)
        }
        let apiService = ApiService()
        // swiftlint:disable:next line_length
        let postData = MentorPostData(name: mentor.name, email: mentor.email, password: mentor.password, graduationYear: mentor.yearOfGrad, college: mentor.university, major: mentor.major, minor: mentor.minor, career: mentor.intendedCareer, topicsOfExpertise: topicString, mentorMotivation: mentor.mentorMotivation, organizationId: mentor.organizationId, personalAccessToken: mentor.personalAccessToken)
        await apiService.postMentorData(data: postData)
    }
}
