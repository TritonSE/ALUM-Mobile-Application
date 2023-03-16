//
//  MentorProfileMenteeView.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import SwiftUI

import WrappingHStack

struct MentorProfileMenteeView: View {
    @StateObject private var viewModel = MentorProfileViewmodel()
    var body: some View {
        GeometryReader { grr in
            VStack {
                ZStack {
                    HStack{
                        Button {
                        } label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 6, height: 12)
                            Text("xxx")
                                .font(.custom("Metropolis-Regular", size: 13, relativeTo: .footnote))
                        }
                        .padding(.leading, 20)
                        .padding(.top)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        Spacer()
                    }
                    Text("Mentor Profile")
                        .frame(width: 240)
                        .padding(.top)
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
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
                                    .scaledToFit()
                                    .frame(width: 135, height: 135)
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
                    Button {
                    } label: {
                        Text("Book Session via Calendly")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .buttonStyle(FilledInButtonStyle())
                    .frame(width: 358)
                    .padding(.bottom, 26)
                    HStack{
                        Text("About")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    // swiftlint:disable:next line_length
                    HStack{
                        Text(viewModel.mentor.mentorMotivation)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .lineSpacing(5)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                    HStack{
                        Text("Topics of Expertise")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    WrappingHStack(0 ..< viewModel.mentor.topicsOfExpertise.count, id: \.self) { index in
                        TagDisplay(text: viewModel.mentor.topicsOfExpertise[index])
                            .padding(.vertical, 5)
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                }
                .frame(minHeight: grr.size.height-105)
                .background(Color("ALUM White2"))
                .padding(.top)
            }
        }
    }
}

struct MentorProfileMenteeView_Previews: PreviewProvider {
    static var previews: some View {
        MentorProfileMenteeView()
    }
}
