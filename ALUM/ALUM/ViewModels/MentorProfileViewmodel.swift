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
        topicsOfExpertise: ["CS", "AP", "Hi"]))
    @Published var selfView = true

    func getMentorInfo(userID: String) async throws {
        guard let mentorData = try? await UserService().getMentor(userID: userID) else {
            print("Error getting info")
            return
        }
        mentorGET = mentorData
        //id is an optional parameter, used to check who is viewing profile
        selfView = (mentorGET.mentor.id != nil)
    }
}
