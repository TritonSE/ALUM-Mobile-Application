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
                    Button("View My Calendly") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
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
                    .padding(.bottom, 58)
                    HStack{
                        Text("Topics of Expertise")
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("ALUM Dark Blue"))
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    WrappingHStack(0 ..< viewModel.mentor.topicsOfExpertise.count, id: \.self) { index in
                        viewModel.mentor.topicsOfExpertise[index]
                            .padding(.vertical, 5)
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    Group{
                        HStack{
                            Text("My Mentees")
                                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                .foregroundColor(Color("ALUM Dark Blue"))
                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.top, 27)
                        HStack(spacing: 18.5) {
                            ForEach(0 ..< viewModel.mentor.mentees.count - 1, id: \.self) { index in
                                if index < 3 {
                                    MenteeCard(name: viewModel.mentor.mentees[index])
                                } else {
                                    
                                }
                            }
                        }
                        .padding(.bottom , 30)
                        .offset(y: -20)
                    }
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
                            .offset(y: -47)
                            .offset(x: 118)
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
                            Button {
                            } label: {
                                VStack{
                                    Image("ALUM Calendar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 27)
                                    Text("Sessions")
                                }
                                .font(.custom("Metropolis-Regular", size: 10, relativeTo: .caption2))
                            }
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .padding(.leading, 82)
                            .padding(.trailing, 75)
                            Button {
                            } label: {
                                VStack{
                                    ZStack{
                                        Image("GrayCircle")
                                            .padding(.trailing, 12)
                                        Image("ALUM Logo 2")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 27)
                                    }
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

struct MentorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MentorProfileView()
    }
}
