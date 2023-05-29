//
//  SessionModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

struct Session {
    var preSessionID: String
    var menteePostSessionID: String
    var mentorPostSessionID: String
    var mentor: MentorGetData
    var mentee: MenteeGetData
    var day: String
    var date: String
    var startTime: String
    var endTime: String
    // var location: String
    // we can get location as mentor.zoomLink

}

struct SessionModel: Decodable {
    var preSession: String
    var postSessionMentee: String?
    var postSessionMentor: String?
    var menteeId: String
    var mentorId: String
    var menteeName: String
    var mentorName: String
    var fullDateString: String
    var dateShortHandString: String
    var startTimeString: String
    var endTimeString: String
    var preSessionCompleted: Bool
    var postSessionMenteeCompleted: Bool
    var postSessionMentorCompleted: Bool
    var hasPassed: Bool
    var location: String
    var missedSessionReason: String?
}
