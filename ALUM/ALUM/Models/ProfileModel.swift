//
//  ProfileModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/8/23.
//

import Foundation
import SwiftUI

struct MenteeProfile {
    var name: String
    var email: String
    var grade: String
    var topicsOfInterest: [TagDisplay]
    var careerInterests: [TagDisplay]
    var mentorshipGoal: String
    var profilePic: Image
    var mentor: String
}

struct MentorProfile {
    var name: String
    var email: String
    var yearOfGrad: String
    var university: String
    var major: String
    var minor: String
    var intendedCareer: String
    var topicsOfExpertise: [TagDisplay]
    var mentorMotivation: String
    var organizationId: String
    var personalAccessToken: String
    var mentees: [String]
    var profilePic: Image
}
