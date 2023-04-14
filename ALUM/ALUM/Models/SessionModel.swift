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
    
    init(mentor: MentorInfo = MentorInfo(), mentee: MenteeInfo = MenteeInfo(), dateTime: Date = Date()) {
        self.mentor = mentor
        self.mentee = mentee
        self.dateTime = dateTime
    }
}
