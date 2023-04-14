//
//  SessionModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

struct Session {
    var mentor: MentorInfo
    var mentee: MenteeInfo
    var dateTime: Date
    // var location: String
    // we can get location as mentor.zoomLink
    
    init(mentor: MentorInfo = MentorInfo(
        menteeIDs: ["u123", "u1234", "abc"],
        name: "Timby Twolf",
        imageId: "34709134",
        about: "I love chocolate",
        calendlyLink: "asdasd",
        graduationYear: 2016,
        college: "UCSD",
        major: "CS",
        minor: "Business",
        career: "SWE",
        topicsOfExpertise: ["CS", "AP", "Hi"]), mentee: MenteeInfo = MenteeInfo(
            id: "u123",
            name: "Timby Twolf",
            imageId: "23462",
            about: "I love caramel",
            grade: 10,
            topicsOfInterest: ["AP", "CS"],
            careerInterests: ["SWE"]), dateTime: Date = Date()) {
        self.mentor = mentor
        self.mentee = mentee
        self.dateTime = dateTime
    }
}
