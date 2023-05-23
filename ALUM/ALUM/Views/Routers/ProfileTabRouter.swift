//
//  ProfileTabRouter.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/23/23.
//

import SwiftUI

struct ProfileTabRouter: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        Group {
            switch self.currentUser.role {
            case .some(UserRole.mentor):
                MentorProfileScreen(uID: self.currentUser.uid!)
            case .some(UserRole.mentee):
                MenteeProfileScreen(uID: self.currentUser.uid!)
            case .none:
                Text("Internal Error: User Role is nil")
            }
        }
        .customNavigationTitle("My Profile")
    }
}

struct ProfileTabRouter_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabRouter()
    }
}
