//
//  ProfileModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/8/23.
//

import Foundation
import SwiftUI

struct MentorInfo: Decodable {
    var menteeIds: [String]?
    var id: String
    var name: String
    var imageId: String
    var about: String
    var calendlyLink: String
    var zoomLink: String
    var graduationYear: Int
    var college: String
    var major: String
    var minor: String
    var career: String
    var topicsOfExpertise: [String]
    var mentorMotivation: String?
    var status: String?
    var whyPaired: String?

    // coding keys are for JSONDecoding
    private enum CodingKeys: String, CodingKey {
        case menteeIds
        case id = "mentorId"
        case name
        case imageId
        case about
        case calendlyLink
        case zoomLink
        case graduationYear
        case college
        case major
        case minor
        case career
        case topicsOfExpertise
        case mentorMotivation
        case status
        case whyPaired
    }
}

struct MenteeInfo: Decodable {
    var id: String
    var name: String
    var imageId: String
    var about: String
    var grade: Int
    var topicsOfInterest: [String]
    var careerInterests: [String]
    var mentorshipGoal: String?
    var mentorId: String?
    var status: String?
    var whyPaired: String?

    // coding keys are for JSONDecoding
    private enum CodingKeys: String, CodingKey {
        case id = "menteeId"
        case name
        case imageId
        case about
        case grade
        case topicsOfInterest
        case careerInterests
        case mentorshipGoal
        case mentorId
        case status
        case whyPaired
    }
}
