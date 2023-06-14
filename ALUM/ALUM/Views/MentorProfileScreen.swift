//
//  MentorProfileScreen.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/3/23.
//

import SwiftUI
import WrappingHStack

struct MentorProfileScreen: View {
    @StateObject private var viewModel = MentorProfileViewModel()
    @State var scrollAtTop: Bool = true
    @State var uID: String = ""
    @State public var showWebView = false
    @State var prevView: AnyView = AnyView(LoadingView(text: ""))
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        Group {
            if viewModel.isLoading() {
                LoadingView(text: "MentorProfileScreen")
            } else {
                content
                    .customNavigationIsPurple(scrollAtTop)
                    .padding(.top, 0)
            }
        }
        .onAppear(perform: {
            Task {
                do {
                    try await viewModel.fetchMentorInfo(userID: uID)
                } catch {
                    print("Error")
                }
            }
        })
    }

    var content: some View {
        let mentor = viewModel.mentor!

        return GeometryReader { grr in
            VStack(spacing: 0) {
                ScrollView {
                    GeometryReader { geo in
                        Rectangle()
                            .frame(width: 0, height: 0)
                            .background(Color("ALUM Primary Purple"))
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .onChange(of: geo.frame(in: .global).midY) { midY in
                                scrollAtTop = midY >= -30.0
                            }
                    }
                    .frame(width: 0, height: 0)
                    header
                    description
                    Button {
                        showWebView.toggle()
                        print("Viewing Calendly")
                    } label: {
                        Text(viewModel.selfView! ? "View My Calendly" : "Book Session via Calendly")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .sheet(isPresented: $showWebView) {
                        if viewModel.selfView! {
                            CalendlyView()
                        } else {
                            CalendlyView(requestType: "POST")
                        }
                    }
                    .buttonStyle(FilledInButtonStyle())
                    .frame(width: 358)
                    .padding(.bottom, 26)
                    about
                    if viewModel.selfView! {
                        mentees
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
                    ProfileHeaderComponent(editDestination: EditMentorProfileScreen(uID: uID))
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

extension MentorProfileScreen {
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
            Text(viewModel.mentor!.name)
                .font(Font.custom("Metropolis-Regular", size: 34, relativeTo: .largeTitle))
        }
    }

    private var description: some View {
        Group {
            HStack {
                Image(systemName: "graduationcap")
                    .frame(width: 25.25, height: 11)
                    .foregroundColor(Color("ALUM Primary Purple"))
                Text(viewModel.mentor!.major + " @ " + viewModel.mentor!.college)
                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
            }
            .padding(.bottom, 6)
            HStack {
                Image(systemName: "suitcase")
                    .frame(width: 25.25, height: 11)
                    .foregroundColor(Color("ALUM Primary Purple"))
                Text(viewModel.mentor!.career)
                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
            }
            .padding(.bottom, 6)
            Text("NHS " + String(viewModel.mentor!.graduationYear))
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .padding(.bottom, 6)
        }
    }

    private var about: some View {
        Group {
            Text("About")
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .foregroundColor(Color("ALUM Primary Purple"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.bottom, 8)
            Text(viewModel.mentor!.about)
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            RenderTags(tags: viewModel.mentor!.topicsOfExpertise, title: "Topics of Expertise")
                .padding(.leading, 16)
                .padding(.bottom, 8)
        }
    }

    private var mentees: some View {
        Group {
            Text("My Mentees")
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .foregroundColor(Color("ALUM Primary Purple"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.top, 27)
            WrappingHStack(0 ..< viewModel.mentor!.menteeIds!.count, id: \.self) { index in
                CustomNavLink(destination:
                                MenteeProfileScreen(
                                    uID: viewModel.mentor!.menteeIds![index]
                                )
                                    .customNavigationTitle("Mentee Profile")
                ) {
                    MenteeCard(isEmpty: true, uID: viewModel.mentor!.menteeIds![index])
                        .padding(.bottom, 15)
                        .padding(.trailing, 10)
                }
            }
            .padding(.bottom, 30)
            .padding(.leading, 16)
            .offset(y: -20)
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

struct MentorProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserModel.shared.setCurrentUser(
            isLoading: false,
            isLoggedIn: true,
            uid: "6431b9a2bcf4420fe9825fe5",
            role: .mentor
        )
        return CustomNavView {
            MentorProfileScreen(uID: "6431b9a2bcf4420fe9825fe5")
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
