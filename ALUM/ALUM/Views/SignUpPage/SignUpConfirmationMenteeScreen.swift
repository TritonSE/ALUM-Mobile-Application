//
//  SignUpConfirmationMenteeScreen.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/15/23.
//

import SwiftUI
import WrappingHStack

struct SignUpConfirmationMenteeScreen: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpViewModel

    var body: some View {
        Group {
            if viewModel.isSubmitting {
                LoadingView(text: "Submitting Mentee Application")
            } else {
                VStack {
                    StaticProgressBarComponent(nodes: 3, filledNodes: 3, activeNode: -1)
                        .background(Color.white)
                    ScrollView {
                        content
                    }
                    footer
                        .padding(.horizontal, 16)
                        .padding(.top, 32)
                        .padding(.bottom, 40)
                        .background(Rectangle().fill(Color.white).shadow(radius: 8))
                }
                .edgesIgnoringSafeArea(.bottom)
                .applySignUpScreenHeaderModifier()
            }
        }
    }

    var footer: some View {
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

            Spacer()
            
            NavigationLink(
                destination: ConfirmationScreen(
                    text: ["We have received your application!",
                       "It usually takes 3-5 days to process your application as a mentee",
                       "Great"],
                    userLoggedIn: false
                ),
                isActive: $viewModel.submitSuccess,
                label: {
                    Button("Submit") {
                        Task {
                            await viewModel.submitMenteeSignUp()
                        }
                    }
                    .buttonStyle(FilledInButtonStyle())
                }
            )
        }
    }

    var content: some View {
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
                Text("\(viewModel.mentee.grade)")
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
}

struct SignUpConfirmationMenteeScreen_Previews: PreviewProvider {

    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpConfirmationMenteeScreen(viewModel: viewModel)
    }
}
