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
        VStack {
            ProgressBarComponent(nodes: 3, filledNodes: 3, activeNode: -1)
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
            Button("Submit") {
                Task {
                    do {
                        try await viewModel.submitMenteeSignUp()
                        self.viewModel.submitSuccess = true
                    } catch {
                        print("Error")
                    }
                }
            }
            .buttonStyle(FilledInButtonStyle())

            NavigationLink(destination: LoginPageView(), isActive: $viewModel.submitSuccess) {
                EmptyView()
            }
        }
    }

    var content: some View {
        VStack {
            HStack {
                ALUMText(text: "Confirmation", fontSize: .largeFontSize)
                    .foregroundColor(Color("NeutralGray3"))
                    .padding(.leading)
                    .padding(.top)
                Spacer()
            }
            .padding(.bottom, 24)
            HStack {
                ALUMText(text: "Name: ")
                    .padding(.leading)
                    .foregroundColor(Color("ALUM Dark Blue"))
                ALUMText(text: viewModel.mentee.name)
                Spacer()
            }
            .padding(.bottom, 16)
            HStack {
                ALUMText(text: "Email: ")
                    .padding(.leading)
                    .foregroundColor(Color("ALUM Dark Blue"))
                ALUMText(text: viewModel.mentee.email)
                Spacer()
            }
            .padding(.bottom, 16)
            HStack {
                ALUMText(text: "Grade: ")
                    .padding(.leading)
                    .foregroundColor(Color("ALUM Dark Blue"))
                ALUMText(text: "\(viewModel.mentee.grade)")
                Spacer()
            }
            .padding(.bottom, 24)
            VStack {
                HStack {
                    ALUMText(text: "Topics of Interest:")
                        .padding(.leading)
                        .foregroundColor(Color("ALUM Dark Blue"))
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
                    ALUMText(text: "Career Interests:")
                        .padding(.leading)
                        .foregroundColor(Color("ALUM Dark Blue"))
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
                ALUMText(text: "What do you hope to get out of mentorship?")
                    .padding(.leading)
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .padding(.trailing, 37)
                    .lineSpacing(5)
                Spacer()
            }
            .padding(.bottom, 8)
            HStack {
                ALUMText(text: viewModel.mentee.mentorshipGoal)
                    .lineSpacing(5)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                Spacer()
            }
            .padding(.bottom, 100)
        }
    }
}

struct SignUpConfirmation_Previews: PreviewProvider {

    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpConfirmationMentee(viewModel: viewModel)
    }
}
