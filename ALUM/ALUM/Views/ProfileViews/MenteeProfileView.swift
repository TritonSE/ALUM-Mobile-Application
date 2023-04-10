//
//  MenteeProfileView.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import SwiftUI
import WrappingHStack

struct MenteeProfileView: View {
    @StateObject private var viewModel = MenteeProfileViewmodel()
    var body: some View {
        GeometryReader { grr in
            VStack {
                if !viewModel.selfView {
                    // params currently placeholders for later navigation
                    NavigationHeaderComponent(backText: "Login", backDestination: LoginPageView(), title: "Mentee Profile")
                } else {
                    ProfileHeaderComponent(profile: true, title: "Mentee Profile")
                        .padding(.bottom)
                }
                ScrollView {
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(height: 125)
                                .foregroundColor(Color("ALUM Light Blue"))
                                .padding(.bottom, 76)
                            Group {
                                Circle()
                                    .frame(width: 135, height: 145)
                                    .foregroundColor(Color("ALUM White2"))
                                viewModel.mentee.profilePic
                                    .resizable()
                                    .frame(width: 135, height: 135)
                                    .clipShape(Circle())
                                    .scaledToFit()
                            }
                            .padding(.top, 57)
                        }
                        Text(viewModel.mentee.name)
                            .font(Font.custom("Metropolis-Regular", size: 34, relativeTo: .largeTitle))
                    }
                    HStack {
                        Image(systemName: "graduationcap")
                            .frame(width: 25.25, height: 11)
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Text(viewModel.mentee.grade + "th Grade @ NHS")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .padding(.bottom, 18)
                    if !viewModel.selfView {
                        WhyPairedComponent()
                            .padding(.bottom, 16)
                    }
                    Text("About")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    Text(viewModel.mentee.mentorshipGoal)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    RenderTags(tags: viewModel.mentee.careerInterests, title: "Career Interests")
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    RenderTags(tags: viewModel.mentee.topicsOfInterest, title: "Topics of Interest")
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    if viewModel.selfView {
                        Text("My Mentor")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 16)
                            .padding(.leading, 16)
                            .padding(.bottom, 8)
                        MentorCard(name: viewModel.mentee.mentor, major: "CS", university: "UCSD", career: "Software Engineer", profilePic: Image("TestMenteePFP"), isEmpty: false)
                            .padding(.bottom, 10)
                    }
                }
                .frame(minHeight: grr.size.height-120)
                .background(Color("ALUM White2"))
                if viewModel.selfView {
                    NavigationFooter(page: "Profile")
                }
            }
        }
    }
}

struct MenteeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MenteeProfileView()
    }
}
