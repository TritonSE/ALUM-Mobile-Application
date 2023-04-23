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
            ProgressBarComponent(nodes: 3, filledNodes: 1, activeNode: 2)
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
    }

    var footer: some View {
        var continueDestinationView = AnyView(EmptyView())
        var continueDisabled = true
        switch selectedType {
        case .mentee:
            continueDestinationView = AnyView(SignUpMenteeInfoScreen(viewModel: viewModel))
            continueDisabled = false
        case .mentor:
            continueDestinationView = AnyView(SignUpMentorInfoScreen(viewModel: viewModel))
            continueDisabled = false
        default:
            continueDisabled = true
        }

        return HStack {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    ALUMText(text: "Back", textColor: ALUMColor.primaryPurple)
                }
            }
            .buttonStyle(OutlinedButtonStyle(disabled: false))
            .padding(.trailing, 16)
            NavigationLink(destination: continueDestinationView) {
                HStack {
                    ALUMText(text: "Continue", textColor: continueDisabled ? ALUMColor.gray4 : ALUMColor.white)
                    Image(systemName: "arrow.right")
                }
            }
            .buttonStyle(FilledInButtonStyle(disabled: continueDisabled))
        }
    }
    var content: some View {
        VStack {
            HStack {
                ALUMText(text: "I want to join as a...", fontSize: .largeFontSize, textColor: ALUMColor.gray3)
                    .frame(width: 306, height: 41)
                    .padding(.top, 8)
                Spacer()
            }
            .padding(.bottom, 32)

            SignUpJoinOption(title: "Mentee",
                             description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do " +
                             "eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                             isSelected: selectedType == .mentee)
            .onTapGesture {
                selectedType = .mentee
                viewModel.isMentee = true
                viewModel.isMentor = false
            }
            .padding(.bottom, 32)

            SignUpJoinOption(title: "Mentor",
                             description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do " +
                             "eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                             isSelected: selectedType == .mentor)
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
