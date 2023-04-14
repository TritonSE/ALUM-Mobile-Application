//
//  MenteeProfileViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import Foundation
import SwiftUI

final class MenteeProfileViewmodel: ObservableObject {
    @Published var menteeGET = MenteeGetData(
        message: "Hello",
        mentee: MenteeInfo(
            id: "u123",
            name: "Timby Twolf",
            imageId: "23462",
            about: "I love caramel",
            grade: 10,
            topicsOfInterest: ["AP", "CS"],
            careerInterests: ["SWE"]),
        whyPaired: "You two are great")
    @Published var selfView = true
    func getMenteeInfo(userID: String) async throws {
        guard let menteeData = try? await UserService().getMentee(userID: userID) else {
            print("Error getting info")
            return
        }
        menteeGET = menteeData
        selfView = (menteeGET.mentee.id != nil)
    }
}
