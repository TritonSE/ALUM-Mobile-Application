//
//  UserModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 10/31/23.
//

import Foundation

struct MenteeObject {
    var MenteeProfile: MenteeInfo?
    var HomeData: SelfGetData?
    init(MenteeProfile: MenteeInfo? = nil, HomeData: SelfGetData? = nil) {
        self.MenteeProfile = MenteeProfile
        self.HomeData = HomeData
    }
}

struct MentorObject {
    var MentorProfile: MentorInfo?
    var HomeData: SelfGetData?
    init(MentorProfile: MentorInfo? = nil, HomeData: SelfGetData? = nil) {
        self.MentorProfile = MentorProfile
        self.HomeData = HomeData
    }
}
