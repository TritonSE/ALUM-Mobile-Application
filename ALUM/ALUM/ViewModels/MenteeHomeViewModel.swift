//
//  MenteeHomeViewModel.swift
//  ALUM
//
//  Created by Yash Ravipati on 11/1/23.
//

import Foundation
import SwiftUI

final class MenteeHomeViewModel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    @Published var mentee: SelfGetData?

    func getMenteeHome() async throws {
        guard let menteeHomeData = try? await UserService.shared.getSelf() else {
            print("Error getting info")
            return
        }

        DispatchQueue.main.async {
            self.mentee = menteeHomeData
            self.currentUser.menteeObj.HomeData = menteeHomeData
        }
    }

    func isLoading() -> Bool {
        return mentee == nil
    }
}
