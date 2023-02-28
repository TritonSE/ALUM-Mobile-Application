//
//  SignUpConfirmation.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/15/23.
//

import SwiftUI
import WrappingHStack

struct SignUpConfirmation: View {
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
                                    .font(.custom("Metropolis-Regular", size: 13, relativeTo: .footnote))
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
                                Text(viewModel.mentee.name)
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Spacer()
                            }
                            .padding(.bottom, 16)
                            HStack {
                                Text("Email: ")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Text(viewModel.mentee.email)
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Spacer()
                            }
                            .padding(.bottom, 16)
                            HStack {
                                Text("Grade: ")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Text(viewModel.mentee.grade)
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Spacer()
                            }
                            .padding(.bottom, 24)
                            HStack {
                                Text("Topics of Interest:")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Spacer()
                            }
                            WrappingHStack(0 ..< viewModel.mentee.topicsOfInterest.count, id: \.self) { index in
                                viewModel.mentee.topicsOfInterest[index]
                                    .padding(.vertical, 5)
                            }
                            .padding(.horizontal)
                            HStack {
                                Text("Career Interests:")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                Spacer()
                            }
                            .padding(.top, 24)
                            WrappingHStack(0 ..< viewModel.mentee.careerInterests.count, id: \.self) { index in
                                viewModel.mentee.careerInterests[index]
                                    .padding(.vertical, 5)
                            }
                            .padding(.horizontal)
                            HStack {
                                Text("What do you hope to get out of mentorship?")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    .padding(.trailing, 37)
                                    .lineSpacing(5)
                                Spacer()
                            }
                            .padding(.top, 24)
                            HStack {
                                Text(viewModel.mentee.mentorshipGoal)
                                    .padding(.leading)
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    .lineSpacing(5)
                                Spacer()
                            }
                            .padding(.top, 8)
                        }
                    }
                    .frame(minHeight: grr.size.height-114)
                    .background(Color("ALUM White2"))
                    .padding(.top)
                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .frame(width: .infinity, height: 114)
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
                                    viewModel.submitSignUp()
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

struct SignUpConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        SignUpConfirmation()
    }
}
