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
            
            ALUMText(text: "Welcome to ALUM", fontSize: .largeFontSize)
                .foregroundColor(Color("ALUM Dark Blue"))
                .frame(width: 306, height: 41)
                .padding(.bottom, 64)
            
            InputValidationComponent(text: $viewModel.email, componentName: ALUMText(text: "Email: "), labelText: "Email", showCheck: false,
                                     functions: viewModel.emailFunc)
            .padding(.bottom, 22)
            
            Group {
                InputValidationComponent(
                    text: $viewModel.password,
                    componentName: ALUMText(text: "Password: "),
                    labelText: "Password",
                    isSecured: true,
                    showEye: true,
                    showCheck: false,
                    functions: viewModel.passFunc
                )
                .padding(.bottom, 6)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: SignUpPageView(), label: {
                        ALUMText(text: "Forgot Password", fontSize: .smallFontSize, isUnderlined: true)
                    })
                    .foregroundColor(.black)
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
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 32)
            } else {
                Button("Login") {
                    viewModel.emailFunc = [LoginPageViewModel.Functions.EnterEmail]
                    viewModel.passFunc = [LoginPageViewModel.Functions.EnterPassword]
                }
                .buttonStyle(FilledInButtonStyle(disabled: true))
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 32)
            }
            
            HStack {
                ALUMText(text: "Don't have an account?")
                NavigationLink(destination: SignUpPageView(), label: {
                    Text("Sign-Up")
                        .underline()
                })
                .foregroundColor(Color("ALUM Medium Blue"))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
