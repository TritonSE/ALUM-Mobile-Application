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
        ZStack {
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
            errorMessage
        }
    }

    var errorMessage: some View {
        Group {
            if self.currentUser.showInternalError
                || self.currentUser.showNetworkError
                || self.currentUser.errorMessage != nil {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        VStack(spacing: 12) {
                            if self.currentUser.showNetworkError {
                                Image("NoConnectionIcon")
                                Text("No internet connection")
                                    .font(Font.custom("Metropolis-Regular", size: 17))
                                Text("Please check your connection and try again.")
                                    .font(.custom("Metropolis-Regular", size: 13))
                                    .foregroundColor(Color("NeutralGray2"))
                            }

                            if self.currentUser.showInternalError || self.currentUser.errorMessage != nil {
                                Image(systemName: "xmark.circle")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color("ALUM Alert Red"))
                                Text("Something went wrong")
                                    .font(Font.custom("Metropolis-Regular", size: 17))
                                Text(self.currentUser.errorMessage ?? "Please contact the ALUM team.")
                                    .font(.custom("Metropolis-Regular", size: 13))
                                    .foregroundColor(Color("NeutralGray2"))
                            }

                            Button("Dismiss") {
                                self.currentUser.showInternalError = false
                                self.currentUser.showNetworkError = false
                                self.currentUser.errorMessage = nil
                            }
                            .frame(minWidth: 50, maxWidth: 100)
                            .frame(minHeight: 0, maxHeight: 48)
                            .padding(.top, 20)
                            .buttonStyle(FilledInButtonStyle(disabled: false))
                        }
                        .frame(width: geometry.size.width)
                        .padding(.vertical, 36)
                        .background(Rectangle().fill(Color.white).shadow(radius: 8))
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
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
        CurrentUserModel.shared.errorMessage = "This is a custom error."
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
