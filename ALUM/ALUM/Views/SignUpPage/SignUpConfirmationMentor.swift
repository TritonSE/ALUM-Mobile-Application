//
//  SignUpConfirmationMentor.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/1/23.
//

import SwiftUI
import WrappingHStack

struct SignUpConfirmationMentor: View {
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
                        try await viewModel.submitMentorSignUp()
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
                ALUMText(text: "Confirmation", fontSize: .largeFontSize, textColor: ALUMColor.gray3)
                    .padding(.leading)
                    .padding(.top)
                Spacer()
            }
            .padding(.bottom, 24)
            HStack {
                ALUMText(text: "Name: ")
                    .padding(.leading)
                ALUMText(text: viewModel.mentor.name, textColor: ALUMColor.black)
                Spacer()
            }
            .padding(.bottom, 16)
            HStack {
                ALUMText(text: "Email: ")
                    .padding(.leading)
                ALUMText(text: viewModel.mentor.email, textColor: ALUMColor.black)
                Spacer()
            }
            .padding(.bottom, 24)
            Group {
                HStack {
                    ALUMText(text: "School: ")
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    ALUMText(text: viewModel.mentor.university, textColor: ALUMColor.black)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            Group {
                HStack {
                    ALUMText(text: "Major")
                        .padding(.leading)
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    ALUMText(text: viewModel.mentor.major, textColor: ALUMColor.black)
                        .padding(.leading)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            Group {
                HStack {
                    ALUMText(text: "Minor")
                        .padding(.leading)
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    ALUMText(text: viewModel.mentor.minor, textColor: ALUMColor.black)
                        .padding(.leading)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            Group {
                HStack {
                    ALUMText(text: "Intended Career")
                        .padding(.leading)
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    ALUMText(text: viewModel.mentor.intendedCareer, textColor: ALUMColor.black)
                        .padding(.leading)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            VStack {
                HStack {
                    ALUMText(text: "Topics of Expertise:")
                        .padding(.leading)
                        .padding(.bottom, 8)
                    Spacer()
                }
                WrappingHStack(viewModel.mentor.topicsOfExpertise.sorted(), id: \.self) { topic in
                    TagDisplay(
                        tagString: topic,
                        crossShowing: true,
                        crossAction: {
                            viewModel.mentor.topicsOfExpertise.remove(topic)
                        }
                    )
                    .padding(.bottom, 8)
                }
                .padding(.trailing, 16)
                .padding(.leading, 16)
            }
            .padding(.bottom, 32)
            Group {
                HStack {
                    ALUMText(text: "Mentor Motivation")
                        .padding(.leading)
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    ALUMText(text: viewModel.mentor.mentorMotivation, textColor: ALUMColor.black)
                        .padding(.leading)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 100)
            }
        }
    }
}

struct SignUpConfirmationMentor_Previews: PreviewProvider {
    static private var viewModel = SignUpViewModel()
    static var previews: some View {
        SignUpConfirmationMentor(viewModel: viewModel)
    }
}
