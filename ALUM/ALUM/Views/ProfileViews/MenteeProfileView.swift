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
                    Group{
                        Text("Career Interests")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                            .padding(.bottom, 4)
                        WrappingHStack(0 ..< viewModel.mentee.careerInterests.count, id: \.self) { index in
                            TagDisplay(tagString: viewModel.mentee.careerInterests[index])
                                .padding(.vertical, 5)
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    }
                    Text("Topics of Interest")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.bottom, 4)
                    WrappingHStack(0 ..< viewModel.mentee.topicsOfInterest.count, id: \.self) { index in
                        TagDisplay(tagString: viewModel.mentee.topicsOfInterest[index])
                            .padding(.vertical, 5)
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    Text("My Mentor")
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                    MentorCard(name: viewModel.mentee.mentor, major: "CS", university: "UCSD", career: "Software Engineer", profilePic: Image("TestMenteePFP"), isEmpty: false)
                        .padding(.bottom, 10)
                        .padding(.trailing, 25)
                }
                .frame(minHeight: grr.size.height-105)
                .background(Color("ALUM White2"))
                .padding(.top)
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(height: 82)
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: 8.0)
                            .frame(width: 64, height: 3)
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .offset(y: -55)
                            .offset(x: 80)
                        HStack {
                            Button {
                            } label: {
                                VStack{
                                    Image("ALUM Home")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 27)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                    Text("Home")
                                }
                                .font(.custom("Metropolis-Regular", size: 10, relativeTo: .caption2))
                            }
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .padding(.trailing, 126)
                            Button {
                            } label: {
                                VStack {
                                    viewModel.mentee.profilePic
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 27, height: 27)
                                    Text("Profile")
                                }
                                .font(.custom("Metropolis-Regular", size: 10, relativeTo: .caption2))
                            }
                            .foregroundColor(Color("ALUM Dark Blue"))
                        }
                        .padding(.bottom, 25)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}


struct MenteeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MenteeProfileView()
    }
}
