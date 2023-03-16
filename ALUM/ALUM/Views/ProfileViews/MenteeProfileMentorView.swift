//
//  MenteeProfileMentorView.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import SwiftUI
import WrappingHStack

struct MenteeProfileMentorView: View {
    @StateObject private var viewModel = MenteeProfileViewmodel()
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
                    Text("Mentee Profile")
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
                                viewModel.mentee.profilePic
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 135, height: 135)
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
                        Text(viewModel.mentee.mentorshipGoal)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .lineSpacing(5)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                    Group{
                        HStack{
                            Text("Career Interests")
                                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                .foregroundColor(Color("ALUM Dark Blue"))
                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 4)
                        WrappingHStack(0 ..< viewModel.mentee.careerInterests.count, id: \.self) { index in
                            TagDisplay(text: viewModel.mentee.careerInterests[index])
                                .padding(.vertical, 5)
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    }
                    HStack{
                        Text("Topics of Interest")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    WrappingHStack(0 ..< viewModel.mentee.topicsOfInterest.count, id: \.self) { index in
                        TagDisplay(text: viewModel.mentee.topicsOfInterest[index])
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

struct MenteeProfileMentorView_Previews: PreviewProvider {
    static var previews: some View {
        MenteeProfileMentorView()
    }
}
