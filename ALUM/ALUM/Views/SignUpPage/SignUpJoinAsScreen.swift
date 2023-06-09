//
//  SignUpJoinAsScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpJoinAsScreen: View {

    enum JoinType {
        case mentee
        case mentor
    }

    @ObservedObject var viewModel: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectedType: JoinType?

    var body: some View {
        VStack {
            StaticProgressBarComponent(nodes: 3, filledNodes: 1, activeNode: 2)
                .background(Color.white)
            ScrollView {
                content
            }
            footer
                .padding(.horizontal, 16)
                .padding(.top, 32)
                .padding(.bottom, 40)
        }
        .edgesIgnoringSafeArea(.bottom)
        .applySignUpScreenHeaderModifier()
        .dismissKeyboardOnDrag()
    }

    var footer: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                }
            }
            .buttonStyle(OutlinedButtonStyle(disabled: false))
            .padding(.trailing, 16)

            if selectedType == .mentee {
                NavigationLink(destination: SignUpMenteeInfoScreen(viewModel: viewModel)) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right")
                    }

                }
                .buttonStyle(FilledInButtonStyle(disabled: false))
            } else if selectedType == .mentor {
                NavigationLink(destination: SignUpMentorInfoScreen(viewModel: viewModel)) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right")
                    }
                }
                .buttonStyle(FilledInButtonStyle(disabled: false))
            } else {
                Button {

                } label: {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right")
                    }
                }
                .disabled(true)
                .buttonStyle(FilledInButtonStyle(disabled: true))
            }
        }

    }
    var content: some View {
        VStack {
            HStack {
                Text("I want to join as a...")
                    .font(.custom("Metropolis-Regular", size: 34))
                    .foregroundColor(Color("NeutralGray3"))
                    .frame(width: 306, height: 41)
                    .padding(.top, 8)
                Spacer()
            }
            .padding(.bottom, 32)

            SignUpJoinOption(
                title: "Mentee",
                description: "Gain valuable insights and support from dedicated alumni mentors.",
                isSelected: selectedType == .mentee
            )
            .onTapGesture {
                selectedType = .mentee
                viewModel.isMentee = true
                viewModel.isMentor = false
            }
            .padding(.bottom, 32)

            SignUpJoinOption(
                title: "Mentor",
                description: 
                    "Empower students as an alumni mentor offering personalized support and guidance. ",
                isSelected: selectedType == .mentor
            )
            .onTapGesture {
                selectedType = .mentor
                viewModel.isMentee = false
                viewModel.isMentor = true
            }
            .padding(.bottom, 137)

        }
        .onAppear {
            if viewModel.isMentee {
                selectedType = .mentee
            } else if viewModel.isMentor {
                selectedType = .mentor
            }
        }
    }
}

struct SignUpJoinAsScreen_Previews: PreviewProvider {

    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpJoinAsScreen(viewModel: viewModel)
    }
}
