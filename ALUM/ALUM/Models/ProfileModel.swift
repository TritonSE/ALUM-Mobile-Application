//
//  ProfileModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/8/23.
//

import Foundation
import SwiftUI

struct MentorGetData: Decodable {
    var message: String
    var mentor: MentorInfo
    var whyPaired: String?
}

struct MentorInfo: Decodable {
    var menteeIDs: [String]?
    var id: String?
    var name: String
    var imageId: String
    var about: String
    var calendlyLink: String
    var graduationYear: Int
    var college: String
    var major: String
    var minor: String
    var career: String
    var topicsOfExpertise: [String]
    var mentorMotivation: String?
    var pairingIds: [String]?
    var organizationId: String?
    var personalAccessToken: String?
    var status: String?
    var mongoVersion: Int?
    var whyPaired: String?

    private enum CodingKeys: String, CodingKey {
        case menteeIDs
        case id = "_id"
        case name
        case imageId
        case about
        case calendlyLink
        case graduationYear
        case college
        case major
        case minor
        case career
        case topicsOfExpertise
        case mentorMotivation
        case pairingIds
        case organizationId
        case personalAccessToken
        case status
        case mongoVersion = "__v"
        case whyPaired
    }
}

struct MenteeGetData: Decodable {
    var message: String
    var mentee: MenteeInfo
    var whyPaired: String?
}

struct MenteeInfo: Decodable {
    var id: String?
    var name: String
    var imageId: String
    var about: String
    var grade: Int
    var topicsOfInterest: [String]
    var careerInterests: [String]
    var mentorshipGoal: String?
    var pairingId: String?
    var status: String?
    var mongoVersion: Int?
    var whyPaired: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case imageId
        case about
        case grade
        case topicsOfInterest
        case careerInterests
        case mentorshipGoal
        case pairingId
        case status
        case mongoVersion = "__v"
        case whyPaired
    }
}
