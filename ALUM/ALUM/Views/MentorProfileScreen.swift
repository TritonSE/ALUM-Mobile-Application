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

    var body: some View {
        Group {
            if viewModel.isLoading() {
                LoadingView(text: "MentorProfileScreen")
            } else {
                content
            }
        }.onAppear(perform: {
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
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .onChange(of: geo.frame(in: .global).midY) { midY in
                                scrollAtTop = midY >= -60.0
                            }
                    }
                    .frame(width: 0, height: 0)
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(height: 150)
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
                        Text(mentor.name)
                            .font(Font.custom("Metropolis-Regular", size: 34, relativeTo: .largeTitle))
                    }
                    HStack {
                        Image(systemName: "graduationcap")
                            .frame(width: 25.25, height: 11)
                            .foregroundColor(Color("ALUM Primary Purple"))
                        Text(mentor.major + " @ " + mentor.college)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .padding(.bottom, 6)
                    HStack {
                        Image(systemName: "suitcase")
                            .frame(width: 25.25, height: 11)
                            .foregroundColor(Color("ALUM Primary Purple"))
                        Text(mentor.career)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .padding(.bottom, 6)
                    Text("NHS '19")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .padding(.bottom, 6)
                    Button {
                    } label: {
                        Text(viewModel.selfView! ? "View My Calendly" : "Book Session via Calendly")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .buttonStyle(FilledInButtonStyle())
                    .frame(width: 358)
                    .padding(.bottom, 26)
                    Text("About")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("ALUM Primary Purple"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    Text(mentor.about)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    RenderTags(tags: mentor.topicsOfExpertise, title: "Topics of Expertise")
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    if viewModel.selfView! {
                        Group {
                            Text("My Mentees")
                                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                .foregroundColor(Color("ALUM Primary Purple"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                                .padding(.top, 27)
                            WrappingHStack(0 ..< mentor.menteeIds!.count, id: \.self) { index in
                                NavigationLink(destination:
                                                MenteeProfileScreen(uID: mentor.menteeIds![index])
                                ) {
                                    MenteeCard(isEmpty: true, uID: mentor.menteeIds![index])
                                        .padding(.bottom, 15)
                                        .padding(.trailing, 10)
                                }
                            }
                            .padding(.bottom, 30)
                            .padding(.leading, 16)
                            .offset(y: -20)
                        }
                    }
                }
                .frame(minHeight: grr.size.height - 50)
                .background(Color("ALUM White2"))
                .padding(.bottom, 8)
                .edgesIgnoringSafeArea(.bottom)
            }
            ZStack {
                if !viewModel.selfView! {
                    // params currently placeholders for later navigation
                    if scrollAtTop {
                        NavigationHeaderComponent(
                            backText: "Login",
                            backDestination: LoginScreen(),
                            title: "Mentor Profile",
                            purple: true,
                            showButton: false)
                        .background(Color("ALUM Primary Purple"))
                    } else {
                        NavigationHeaderComponent(
                            backText: "Login",
                            backDestination: LoginScreen(),
                            title: "Mentor Profile",
                            purple: false,
                            showButton: false)
                        .background(.white)
                    }
                } else {
                    if scrollAtTop {
                        ProfileHeaderComponent(profile: true, title: "My Profile", purple: true)
                            .background(Color("ALUM Primary Purple"))
                    } else {
                        ProfileHeaderComponent(profile: true, title: "My Profile", purple: false)
                            .background(.white)
                    }
                }
            }
        }
    }
}

struct MentorProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        MentorProfileScreen(uID: "6431b9a2bcf4420fe9825fe5")
    }
}
