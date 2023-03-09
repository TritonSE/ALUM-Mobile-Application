//
//  MentorProfileViewmodel.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/7/23.
//

import Foundation
import SwiftUI

final class MentorProfileViewmodel: ObservableObject {
    // swiftlint:disable:next line_length
    @Published var mentor = MentorProfile(name: "Jill Doe", email: "jill@gmail.com", yearOfGrad: "2016", university: "UCSD", major: "Computer Science", minor: "N/A", intendedCareer: "Software Engineer", topicsOfExpertise: topics, mentorMotivation: "I love teaching", organizationId: "TSE", personalAccessToken: "123", mentees: ["u12321312", "u12321334", "u123213765", "u1232131342"], profilePic: Image("ALUMLogoBlue"))
}
