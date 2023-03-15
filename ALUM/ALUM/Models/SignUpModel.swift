//
//  SignUpModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/22/23.
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
    var topicsOfInterest: Set<String>
    var careerInterests: Set<String>
    var mentorshipGoal: String
    var password: String
}

struct Mentor {
    var name: String
    var email: String
    var yearOfGrad: String
    var university: String
    var major: String
    var minor: String
    var intendedCareer: String
    var whyMentor: String
    var password: String
}
