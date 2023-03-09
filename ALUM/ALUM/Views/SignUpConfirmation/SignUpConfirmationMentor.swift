//
//  SignUpConfirmationMentor.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/1/23.
//

import SwiftUI
import WrappingHStack

struct SignUpConfirmationMentor: View {
    @StateObject private var viewModel = SignUpConfirmationViewModel()
    var body: some View {
        GeometryReader { grr in
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            Button {
                            } label: {
                                Image(systemName: "chevron.left")
                                    .frame(width: 6, height: 12)
                                Text("Login")
                            }
                            .foregroundColor(Color("ALUM Dark Blue"))
                            Spacer()
                        }
                        .padding(.leading, 25)
                        .padding(.top)
                        Spacer()
                    }
                    VStack {
                        Text("Sign-Up")
                            .padding()
                            .frame(alignment: .center)
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        ProgressBarComponent(nodes: 3, filledNodes: 3, activeNode: -1)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
                ZStack {
                    ScrollView {
                        VStack {
                            HStack {
                                Text("Confirmation")
                                    .font(Font.custom("Metropolis-Regular", size: 34, relativeTo: .largeTitle))

                                    .foregroundColor(Color("NeutralGray3"))
                                    .padding(.leading)
                                    .padding(.top)
                                Spacer()
                            }
                            .padding(.bottom, 24)
                            HStack {
                                Text("Name: ")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Text(viewModel.mentor.name)
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Spacer()
                            }
                            .padding(.bottom, 16)
                            HStack {
                                Text("Email: ")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Text(viewModel.mentor.email)
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Spacer()
                            }
                            .padding(.bottom, 24)
                            Group{
                                HStack {
                                    Text("School: ")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                HStack {
                                    Text(viewModel.mentor.university)
                                        .padding(.leading)
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    Spacer()
                                }
                                .padding(.bottom, 24)
                            }
                            Group{
                                HStack {
                                    Text("Major")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .padding(.trailing, 37)
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                HStack {
                                    Text(viewModel.mentor.major)
                                        .padding(.leading)
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 24)
                            }
                            Group{
                                HStack {
                                    Text("Minor")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .padding(.trailing, 37)
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                HStack {
                                    Text(viewModel.mentor.minor)
                                        .padding(.leading)
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 24)
                            }
                            Group{
                                HStack {
                                    Text("Intended Career")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .padding(.trailing, 37)
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                HStack {
                                    Text(viewModel.mentor.intendedCareer)
                                        .padding(.leading)
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 24)
                            }
                            Group{
                                HStack {
                                    Text("Topics of Expertise:")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    Spacer()
                                }
                                WrappingHStack(0 ..< viewModel.mentor.topicsOfExpertise.count, id: \.self) { index in
                                    viewModel.mentor.topicsOfExpertise[index]
                                        .padding(.vertical, 5)
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 24)
                            }
                            Group{
                                HStack {
                                    Text("Mentor Motivation")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .padding(.trailing, 37)
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                HStack {
                                    Text(viewModel.mentor.mentorMotivation)
                                        .padding(.leading)
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .lineSpacing(5)
                                    Spacer()
                                }
                                .padding(.bottom, 100)
                            }
                        }
                    }
                    .frame(minHeight: grr.size.height-114)
                    .background(Color("ALUM White2"))
                    .padding(.top)
                    //rectangle with edit and submit
                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .frame(height: 114)
                                .foregroundColor(.white)
                            HStack {
                                Button {
                                    
                                } label: {
                                    Label(
                                        title: { Text("Edit") },
                                        icon: { Image(systemName: "pencil.line") }
                                    )
                                }
                                .buttonStyle(OutlinedButtonStyle())
                                .frame(width: 150)
                                .padding(8)
                                Button("Submit") {
                                    Task{
                                        await viewModel.submitMentorSignUp()
                                    }
                                }
                                .buttonStyle(FilledInButtonStyle())
                                .frame(width: 150)
                                .padding(8)
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}

struct SignUpConfirmationMentor_Previews: PreviewProvider {
    static var previews: some View {
        SignUpConfirmationMentor()
    }
}
