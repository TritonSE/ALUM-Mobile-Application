//
//  RootView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/20/23.
//

import SwiftUI

struct RootRouter: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        if self.currentUser.isLoading {
            LoadingView(text: "RootView")
            .onAppear(perform: {
                Task {
                    await self.currentUser.setForInSessionUser()
                }
            })
        } else if self.currentUser.isLoggedIn == false {
            NavigationView {
                LoginScreen()
            }
        } else {
            LoggedInRouter()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootRouter()
    }
}
