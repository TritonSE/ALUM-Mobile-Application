//
//  PostSessionService.swift
//  ALUM
//
//  Created by Adhithya Ananthan on 4/26/23.
//  This file will contain the service function to make a post session route
//  Note that the function in this file should be added to the SessionService page
//  once everything is merged
//

import Foundation


struct SessionPostData {
    var menteeId: String
    var mentorId: String
    var calendlyURI: String
}

struct SessionData {
    
}

class PostSessionService {
    postSessionWithId(menteeId: String, mentorId: String, calendlyURI: String) async throws -> SessionPostData?  {
        
    }
}
