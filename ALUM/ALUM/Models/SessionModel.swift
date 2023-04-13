//
//  SessionModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

struct Session {
    var mentor: Mentor
    var mentee: Mentee
    var dateTime: Date
    var location: String
}

struct GetSession {
    var preSession: String
    var postSession: String
    var menteeId: String
    var mentorId: String
    var dateTime: Date
    
    init(preSession: String = "", postSession: String = "", menteeId: String = "", mentorId: String = "", dateTime: Date = Date()) {
        self.preSession = preSession
        self.postSession = postSession
        self.menteeId = menteeId
        self.mentorId = mentorId
        self.dateTime = dateTime
    }
}
