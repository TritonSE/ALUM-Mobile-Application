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
    var grade: Int
    var topicsOfInterest: Set<String>
    var careerInterests: Set<String>
    var mentorshipGoal: String
    var password: String

    init(name: String = "", email: String = "", grade: Int = 0, topicsOfInterest: Set<String> = [], careerInterests: Set<String> = [], mentorshipGoal: String = "", password: String = "") {
        self.name = name
        self.email = email
        self.grade = grade
        self.topicsOfInterest = topicsOfInterest
        self.careerInterests = careerInterests
        self.mentorshipGoal = mentorshipGoal
        self.password = password
    }
}

struct Mentor {
    var name: String
    var email: String
    var yearOfGrad: Int
    var university: String
    var major: String
    var minor: String
    var intendedCareer: String
    var mentorMotivation: String
    var topicsOfExpertise: Set<String>
    var password: String
    init(name: String = "", email: String = "", yearOfGrad: Int = 0,
         university: String = "", major: String = "", minor: String = "",
         intendedCareer: String = "", mentorMotivation: String = "",
         topicsOfExpertise: Set<String> = [], password: String = "") {
        self.name = name
        self.email = email
        self.yearOfGrad = yearOfGrad
        self.university = university
        self.major = major
        self.minor = minor
        self.intendedCareer = intendedCareer
        self.mentorMotivation = mentorMotivation
        self.topicsOfExpertise = topicsOfExpertise
        self.password = password
    }
}
