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
                    HStack{
                        Image(systemName: "graduationcap")
                            .frame(width: 25.25, height: 11)
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Text(viewModel.mentee.grade + "th Grade @ NHS")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .padding(.bottom, 24)
                    Text("About")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    // swiftlint:disable:next line_length
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


struct MenteeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MenteeProfileView()
    }
}