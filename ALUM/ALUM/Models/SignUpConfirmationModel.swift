//
//  SignUpConfirmationModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/21/23.
//

import Foundation

struct Account {
    var name: String
    var email: String
    var password: String
}

struct Mentee {
    var name: String
    var email: String
    var grade: String
    var topicsOfInterest: [TagDisplay]
    var careerInterests: [TagDisplay]
    var mentorshipGoal: String
    var password: String
}

struct Mentor {
    var name: String
    var email: String
    var yearOfGrad : String
    var university: String
    var major: String
    var minor: String
    var intendedCareer: String
    var topicsOfExpertise: [TagDisplay]
    var mentorMotivation: String
    var organizationId: String
    var personalAccessToken: String
    var password: String
}
