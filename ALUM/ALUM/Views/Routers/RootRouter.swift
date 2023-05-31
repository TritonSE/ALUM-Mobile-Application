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
        } else if self.currentUser.status == "paired" {
            CustomNavView {
                LoggedInRouter(defaultSelection: 0)
            }
        } else {
            UnpairedScreen()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserModel.shared.setCurrentUser(
            isLoading: true,
            isLoggedIn: true,
            uid: "6431b9a2bcf4420fe9825fe5",
            role: .mentor
        )
        return RootRouter().onAppear(perform: {
            Task {
                try await CurrentUserModel.shared.fetchUserInfoFromServer(
                    userId: "6431b9a2bcf4420fe9825fe5",
                    role: .mentor
                )
            }
        })
    }
}
