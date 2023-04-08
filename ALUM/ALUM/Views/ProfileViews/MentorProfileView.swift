//
//  MentorProfileView.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/3/23.
//

import SwiftUI
import WrappingHStack

struct MentorProfileView: View {
    @StateObject private var viewModel = MentorProfileViewmodel()
    var body: some View {
        GeometryReader { grr in
            VStack {
                HStack {
                    Button {
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.leading, 20)
                    .padding(.top)
                    .foregroundColor(Color("ALUM Dark Blue"))
                    Text("My Profile")
                        .frame(width: 240)
                        .padding(.top)
                        .padding(.leading, 25)
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    Button {
                    } label: {
                        Image("ALUM Pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 19.83, height: 19.83)
                            .padding(.trailing, 18.17)
                    }
                    .padding(.leading, 25)
                    .padding(.top, 8)
                    .foregroundColor(Color("ALUM Dark Blue"))
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
                                viewModel.mentor.profilePic
                                    .resizable()
                                    .frame(width: 135, height: 135)
                                    .clipShape(Circle())
                                    .scaledToFit()
                            }
                            .padding(.top, 57)
                        }
                        Text(viewModel.mentor.name)
                            .font(Font.custom("Metropolis-Regular", size: 34, relativeTo: .largeTitle))
                    }
                    HStack{
                        Image(systemName: "graduationcap")
                            .frame(width: 25.25, height: 11)
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Text(viewModel.mentor.major + " @ " + viewModel.mentor.university)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .padding(.bottom, 6)
                    HStack{
                        Image(systemName: "suitcase")
                            .frame(width: 25.25, height: 11)
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Text(viewModel.mentor.intendedCareer)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .padding(.bottom, 6)
                    Text("NHS '19")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .padding(.bottom, 6)
                    if viewModel.selfView {
                        Button {
                        } label: {
                            Text("View My Calendly")
                                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .frame(width: 358)
                        .padding(.bottom, 26)
                    }
                    else {
                        Button {
                        } label: {
                            Text("Book Session via Calendly")
                                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .frame(width: 358)
                        .padding(.bottom, 26)
                    }
                    Text("About")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    // swiftlint:disable:next line_length
                    Text(viewModel.mentor.mentorMotivation)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                    RenderTags(tags: viewModel.mentor.topicsOfExpertise, title: "Topics of Expertise")
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    if viewModel.selfView {
                        Group {
                            Text("My Mentees")
                                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                .foregroundColor(Color("ALUM Dark Blue"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                                .padding(.top, 27)
                            WrappingHStack(0 ..< viewModel.mentor.mentees.count, id: \.self) { index in
                                MenteeCard(name: viewModel.mentor.mentees[index])
                                    .padding(.bottom, 15)
                                    .padding(.trailing, 10)
                            }
                            .padding(.bottom , 30)
                            .padding(.leading, 16)
                            .offset(y: -20)
                        }
                    }
                }
                .frame(minHeight: grr.size.height-105)
                .background(Color("ALUM White2"))
                .padding(.top)
                if viewModel.selfView {
                    NavigationFooter(page: "Profile")
                }
            }
        }
    }
}

struct MentorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MentorProfileView()
    }
}