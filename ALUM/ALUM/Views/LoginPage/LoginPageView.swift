//
//  LoginPageView.swift
//  ALUM
//
//  Created by Harsh Gurnani on 1/31/23.
//

import SwiftUI
import Firebase

struct LoginPageView: View {
    @StateObject private var viewModel = LoginPageViewModel()
    
    var body: some View {
        if viewModel.userIsLoggedIn {
            ContentView()
        } else {
            content
        }
    }

    var content: some View {
        return
        VStack(spacing: 0) {
            Image("ALUMLogoBlue")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.bottom, 16)

            Text("Welcome to ALUM")
                // .font(.largeTitle)
                .font(.custom("Metropolis-Regular", size: 34))
                .foregroundColor(Color("ALUM Dark Blue"))
                .frame(width: 306, height: 41)
                .padding(.bottom, 64)

            InputValidationComponent(text: $viewModel.email, componentName: Text("Email: ")
                .font(.custom("Metropolis-Regular", size: 16)), labelText: "Email", showCheck: false,
                                     functions: viewModel.emailFunc)
                .padding(.bottom, 22)

            Group {
                InputValidationComponent(
                    text: $viewModel.password,
                    componentName: Text("Password: ")
                        .font(.custom("Metropolis-Regular", size: 16)),
                    labelText: "Password",
                    isSecured: true,
                    showEye: true,
                    showCheck: false,
                    functions: viewModel.passFunc
                )
                .padding(.bottom, 6)

                HStack {
                    Spacer()
                    Button(action: {
                    }, label: {
                        Text("Forgot Password")
                            .underline()
                            .foregroundColor(.black)
                            .font(.footnote)
                    })
                }
                .padding(.trailing, 16.0)
                .padding(.bottom, 32)
            }

            if viewModel.email != "" && viewModel.password != "" {
                Button("Login") {
                    viewModel.emailFunc = []
                    viewModel.passFunc = []
                viewModel.login()
                }
                .buttonStyle(FilledInButtonStyle(disabled: false))
                .frame(width: 358)
                .padding(.bottom, 32)
            } else {
                Button("Login") {
                    viewModel.emailFunc = [LoginPageViewModel.Functions.EnterEmail]
                    viewModel.passFunc = [LoginPageViewModel.Functions.EnterPassword]
                }
                .buttonStyle(FilledInButtonStyle(disabled: true))
                .frame(width: 358)
                .padding(.bottom, 32)
            }

        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
