//
//  MentorHomeViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 10/19/23.
//

import Foundation
import SwiftUI

final class MentorHomeViewModel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    @Published var mentor: SelfGetData?

    func getMentorHome() async throws {
        guard let mentorHomeData = try? await UserService.shared.getSelf() else {
            print("Error getting info")
            return
        }

        DispatchQueue.main.async {
            self.mentor = mentorHomeData
            self.currentUser.mentorObj.HomeData = mentorHomeData
        }
    }

    func isLoading() -> Bool {
        return mentor == nil
    }
}
