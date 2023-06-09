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
            InputValidationComponent(
                text: $viewModel.account.email, 
                componentName: Text("Email: ").font(.custom("Metropolis-Regular", size: 16)),
                labelText: "Email", 
                showCheck: true,
                validateInput: viewModel.hasBeenSubmittedOnce,
                functions: viewModel.emailFunc
            )
                .padding(.bottom, 32)
            if $viewModel.account.email.wrappedValue != "" {
                Button("Send Password Reset Email") {
                    Task {
                        await viewModel.resetPassword()
                        viewModel.hasBeenSubmittedOnce = true
                    }
                }
                .buttonStyle(FilledInButtonStyle(disabled: false))
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 32)
            } else {
                Button("Send Password Reset Email") {
                    viewModel.emailFunc = [ForgotPasswordViewModel.Functions.EnterEmail]
                }
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
