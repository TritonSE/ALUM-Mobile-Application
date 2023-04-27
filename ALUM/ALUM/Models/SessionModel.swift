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
    var dateTime: String
    // var location: String
    // we can get location as mentor.zoomLink

}
