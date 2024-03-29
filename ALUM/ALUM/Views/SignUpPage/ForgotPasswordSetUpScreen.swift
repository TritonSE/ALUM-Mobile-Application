//
//  ForgotPasswordView.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 09/05/23.
//

import SwiftUI

struct ForgotPasswordSetUpScreen: View {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    var account = Account(name: "", email: "", password: "")

    var body: some View {
        VStack {
            header
            KeyboardAwareView {
                content
            }
        }
        .dismissKeyboardOnDrag()
    }

    var header: some View {
        VStack {
            VStack {
                NavigationHeaderComponent(
                    backText: "Login",
                    backDestination: LoginScreen(),
                    title: "Forgot Password", purple: false
                )
            }
        }
        .padding(.bottom, 54)
    }

    var content: some View {
        VStack {
            InputValidationComponent(
                text: $viewModel.account.email,
                componentName: Text("Email: ").font(.custom("Metropolis-Regular", size: 16)),
                labelText: "Email",
                showCheck: true,
                functions: [ErrorFunctions.ValidEmail]
            )
                .padding(.bottom, 32)
            if $viewModel.account.email.wrappedValue != "" &&
                (ErrorFunctions.ValidEmail(viewModel.account.email).0) {
                NavigationLink(
                    destination: ConfirmationScreen(
                        text: ["Password Reset email sent!",
                           "Please check your inbox and click the link to reset your password",
                           "Login"],
                        userLoggedIn: false
                    ),
                    isActive: $viewModel.passwordChangeSuccessful,
                    label: {
                        Button("Send Password Reset Email") {
                            Task {
                                await viewModel.resetPassword()
                            }

                            print("this works")
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 32)
                    }
                )
            } else {
                Button("Send Password Reset Email") {
                    viewModel.emailFunc = [ForgotPasswordViewModel.Functions.EnterEmail]
                }
                .disabled(true)
                .buttonStyle(FilledInButtonStyle(disabled: true))
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 32)
            }
            Spacer()
        }
    }
}

struct ForgotPasswordSetUpScreen_Previews: PreviewProvider {
    static private var viewModel = ForgotPasswordViewModel()
    static var previews: some View {
        ForgotPasswordSetUpScreen(viewModel: viewModel)
    }
}
