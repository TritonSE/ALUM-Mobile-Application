//
//  MenteeProfileView.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import SwiftUI
import WrappingHStack

struct MenteeProfileScreen: View {
    @StateObject private var viewModel = MenteeProfileViewmodel()
    @State var scrollAtTop: Bool = true
    @State var uID: String = ""
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        Group {
            if viewModel.isLoading() {
                LoadingView(text: "MenteeProfileScreen")
            } else {
                content
                    .customNavigationIsPurple(scrollAtTop)
                    .padding(.top, 0)
            }
        }.onAppear(perform: {
            Task {
                do {
                    try await viewModel.fetchMenteeInfo(userID: uID)
                } catch {
                    print("Error")
                }
            }
        })
    }

    var content: some View {
        let mentee = viewModel.mentee!

        return
        GeometryReader { grr in
            VStack(spacing: 0) {
                ScrollView {
                    GeometryReader { geo in
                        Rectangle()
                            .frame(width: 0, height: 0)
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .onChange(of: geo.frame(in: .global).midY) { midY in
                                scrollAtTop = midY >= -30.0
                            }
                    }
                    .frame(width: 0, height: 0)
                    header
                    description
                    if viewModel.selfView! {
                        mentor
                        logOutButton
                    }
                }
                .frame(minHeight: grr.size.height - 50)
                .background(Color("ALUM White2"))
                .padding(.bottom, 8)
                .edgesIgnoringSafeArea(.bottom)
            }
            ZStack {
                // Removing this Z-stack causes a white rectangle to appear between the top of screen 
                // and start of this screen due to GeometryReader

                if viewModel.selfView! {
                  // params like settings and edit profile currently placeholders for later navigation
                  if scrollAtTop {
                    ProfileHeaderComponent(profile: true, title: "My Profile", purple: true)
                      .background(Color("ALUM Primary Purple"))
                  } else {
                    ProfileHeaderComponent(profile: true, title: "My Profile", purple: false)
                      .background(.white)
                  }
                } else {
                  if scrollAtTop {
                    Rectangle()
                      .frame(height: 10)
                      .foregroundColor(Color("ALUM Primary Purple"))
                      .frame(maxHeight: .infinity, alignment: .top)
                  }
                }
            }
        }
    }
}

extension MenteeProfileScreen {
    private var header: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(height: 130)
                    .foregroundColor(Color("ALUM Primary Purple"))
                    .padding(.bottom, 76)
                Group {
                    Circle()
                        .frame(width: 135, height: 145)
                        .foregroundColor(Color("ALUM White2"))
                    Image("ALUMLogoBlue")
                        .resizable()
                        .frame(width: 135, height: 135)
                        .clipShape(Circle())
                        .scaledToFit()
                }
                .padding(.top, 57)
            }
            Text(viewModel.mentee!.name)
                .font(Font.custom("Metropolis-Regular", size: 34, relativeTo: .largeTitle))
        }
    }
    private var description: some View {
        Group {
            HStack {
                Image(systemName: "graduationcap")
                    .frame(width: 25.25, height: 11)
                    .foregroundColor(Color("ALUM Primary Purple"))
                Text(String(viewModel.mentee!.grade) + "th Grade @ NHS")
                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
            }
            .padding(.bottom, 18)
            Text("About")
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .foregroundColor(Color("ALUM Primary Purple"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.bottom, 8)
            Text(viewModel.mentee!.about )
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            RenderTags(tags: viewModel.mentee!.careerInterests, title: "Career Interests")
                .padding(.leading, 16)
                .padding(.bottom, 8)
            RenderTags(tags: viewModel.mentee!.topicsOfInterest, title: "Topics of Interest")
                .padding(.leading, 16)
                .padding(.bottom, 8)
        }
    }

    private var mentor: some View {
        Group {
            Text("My Mentor")
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .foregroundColor(Color("ALUM Primary Purple"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.leading, 16)
                .padding(.bottom, 8)
            CustomNavLink(destination:
                            MentorProfileScreen(
                                uID: viewModel.mentee!.mentorId ?? ""
                            )
                                .onAppear(perform: {
                                    currentUser.showTabBar = false
                                })
                                    .onDisappear(perform: {
                                        currentUser.showTabBar = true
                                    })
                                        .customNavigationTitle("Mentor Profile")
            ) {
                MentorCard(isEmpty: true, uID: viewModel.mentee!.mentorId ?? "")
                    .padding(.bottom, 10)
            }
        }
    }

    private var logOutButton: some View {
        Button(action: {
            FirebaseAuthenticationService.shared.logout()
        }, label: {
            HStack {
                ALUMText(text: "Log out", textColor: ALUMColor.red)
                Image("Logout Icon")
            }
        })
        .buttonStyle(FullWidthButtonStyle())
    }
}

struct MenteeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserModel.shared.setCurrentUser(
            isLoading: false,
            isLoggedIn: true,
            uid: "6431b99ebcf4420fe9825fe3",
            role: .mentor
        )
        return CustomNavView {
            MenteeProfileScreen(uID: "6431b99ebcf4420fe9825fe3")
                .onAppear {
                    Task {
                        try await FirebaseAuthenticationService.shared.login(
                            email: "mentor@gmail.com",
                            password: "123456"
                        )
                    }
                }
        }
    }
}
