//
//  SignUpConfirmation.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/15/23.
//

import SwiftUI
import WrappingHStack

struct SignUpConfirmationMentee: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpViewModel
    var body: some View {
        GeometryReader { grr in
            VStack {
                NavigationHeaderComponent(
                    backText: "Login",
                    backDestination: LoginPageView(),
                    title: "Signup"
                )
                ProgressBarComponent(nodes: 3, filledNodes: 3, activeNode: -1)
                    .padding(.horizontal, 10)
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
                            VStack {
                                HStack {
                                    Text("Topics of Interest:")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                        .padding(.bottom, 8)
                                    Spacer()
                                }
                                
                                WrappingHStack(viewModel.mentee.topicsOfInterest.sorted(), id: \.self) { interest in
                                    TagDisplay(
                                        tagString: interest,
                                        crossShowing: true,
                                        crossAction: {
                                            viewModel.mentee.topicsOfInterest.remove(interest)
                                        }
                                    )
                                    .padding(.bottom, 8)
                                }
                                .padding(.trailing, 16)
                                .padding(.leading, 16)
                            }
                            .padding(.bottom, 32)
                            
                            VStack {
                                HStack {
                                    Text("Career Interests:")
                                        .padding(.leading)
                                        .foregroundColor(Color("ALUM Dark Blue"))
                                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                
                                WrappingHStack(viewModel.mentee.careerInterests.sorted(), id: \.self) { interest in
                                    TagDisplay(
                                        tagString: interest,
                                        crossShowing: true,
                                        crossAction: {
                                            viewModel.mentee.careerInterests.remove(interest)
                                        }
                                    )
                                    .padding(.bottom, 16)
                                }
                                .padding(.trailing, 16)
                                .padding(.leading, 16)
                            }
                            .padding(.bottom, 32)
                            
                            HStack {
                                Text("What do you hope to get out of mentorship?")
                                    .padding(.leading)
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    .padding(.trailing, 37)
                                    .lineSpacing(5)
                                Spacer()
                            }
                            .padding(.bottom, 8)
                            HStack {
                                Text(viewModel.mentee.mentorshipGoal)
                                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                    .lineSpacing(5)
                                    .padding(.leading, 16)
                                    .padding(.trailing, 16)
                                Spacer()
                            }
                            .padding(.bottom, 100)
                        }
                    }
                    .frame(minHeight: grr.size.height-114)
                    .background(Color("ALUM White2"))
                    .padding(.top)
                    // rectangle with edit and submit
                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .frame(height: 114)
                                .foregroundColor(.white)
                            HStack {
                                Button {
                                    dismiss()
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
                                    Task {
                                        await viewModel.submitMenteeSignUp()
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
        .navigationBarBackButtonHidden()
    }
}

struct SignUpConfirmation_Previews: PreviewProvider {
    
    static private var viewModel = SignUpViewModel()
    
    static var previews: some View {
        SignUpConfirmationMentee(viewModel: viewModel)
    }
}
