//
//  MentorProfileViewmodel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/7/23.
//

import Foundation
import SwiftUI

final class MentorProfileViewmodel: ObservableObject {
    @Published var mentorGET = MentorGetData(
        message: "Hi I like chocolate",
        mentor: MentorInfo(
        id: "123",
        name: "Timby Twolf",
        imageId: "34709134",
        about: "I love chocolate",
        calendlyLink: "asdasd",
        zoomLink: "zoom.com",
        graduationYear: 2016,
        college: "UCSD",
        major: "CS",
        minor: "Business",
        career: "SWE",
        topicsOfExpertise: ["CS", "AP", "Hi"]))
    @Published var selfView = false

    func getMentorInfo(userID: String) async throws {
        guard let mentorData = try? await UserService().getMentor(userID: userID) else {
            print("Error getting info")
            return
        }
        mentorGET = mentorData
        // motivation is an optional parameter, used to check who is viewing profile
        selfView = (mentorGET.mentor.mentorMotivation != nil)
    }
}
