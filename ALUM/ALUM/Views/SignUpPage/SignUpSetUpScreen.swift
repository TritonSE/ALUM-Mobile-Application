//
//  SignUpSetUpScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpSetUpScreen: View {
    @ObservedObject var viewModel: SignUpViewModel
    var body: some View {
        VStack {
            ProgressBarComponent(nodes: 3, filledNodes: 0, activeNode: 1)
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
        .applySignUpScreenHeaderModifier()
        .onAppear {
            viewModel.emailFunc = [SignUpFlowErrorFunctions.IUSDEmail]
            viewModel.passFunc = [SignUpFlowErrorFunctions.EightChars,
                                  SignUpFlowErrorFunctions.OneNumber,
                                  SignUpFlowErrorFunctions.SpecialChar]
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    var footer: some View {
        HStack {
            Group {
                if viewModel.account.email != "" && viewModel.account.password != "" &&
                    viewModel.account.name != "" && viewModel.passwordAgain != "" &&
                    SignUpFlowErrorFunctions.IUSDEmail(viewModel.account.email).0 &&
                    SignUpFlowErrorFunctions.EightChars(viewModel.account.password).0 &&
                    SignUpFlowErrorFunctions.OneNumber(viewModel.account.password).0 &&
                    SignUpFlowErrorFunctions.SpecialChar(viewModel.account.password).0 &&
                    viewModel.account.password == viewModel.passwordAgain {
                    NavigationLink(destination: SignUpJoinAsScreen(viewModel: viewModel), label: {
                        HStack {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }
                    }
                    )
                    .buttonStyle(FilledInButtonStyle(disabled: false))
                } else {
                    Button {
                        viewModel.checkPasswordSame()
                    } label: {
                        HStack {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .buttonStyle(FilledInButtonStyle(disabled: true))
                }
            }
        }
    }
    var content: some View {
        VStack {
            HStack {
                ALUMText(text: "Account Set-Up", fontSize: .largeFontSize, textColor: ALUMColor.gray3)
                    .frame(width: 306, height: 41)
                Spacer()
            }
            .padding(.bottom, 32)
            .padding(.top, 8)

            InputValidationComponent(
                text: $viewModel.account.email,
                componentName: ALUMText(text: "Email: "),
                labelText: "Email",
                showCheck: true,
                functions: viewModel.emailFunc)
            .padding(.bottom, 32)

            InputValidationComponent(text: $viewModel.account.name, componentName: ALUMText(text: "Name: "), labelText: "Name")
                .padding(.bottom, 32)

            InputValidationComponent(text: $viewModel.account.password, componentName: ALUMText(text: "Password: ")
                                     , labelText: "Password", isSecured: true,
                                     showEye: true, showCheck: true, functions: viewModel.passFunc)
            .padding(.bottom, 32)
            InputValidationComponent(
                text: $viewModel.passwordAgain,
                componentName: ALUMText(text: "Confirm Password: "),
                labelText: "Password",
                isSecured: true,
                showEye: true,
                functions: viewModel.passAgainFunc
            )
            .padding(.bottom, 32)
        }
    }
}

struct SignUpSetUpScreen_Previews: PreviewProvider {
    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpSetUpScreen(viewModel: viewModel)
    }
}
