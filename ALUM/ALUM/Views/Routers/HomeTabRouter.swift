//
//  HomeTabRouter.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/23/23.
//

import SwiftUI

/// For MVP, our home tab is either a session details page or just a screen with pairing info and button to book a session
struct HomeTabRouter: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        Group {
            if currentUser.sessionId == nil {
                HomeScreen()
            } else {
                SessionDetailsScreen(sessionId: currentUser.sessionId!)
                    .customNavigationBarBackButtonHidden(true)
            }
        }
    }
}

struct HomeTabRouter_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabRouter()
    }
}
