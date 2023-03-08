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
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)

            VStack {

                ProgressBarComponent(nodes: 3, filledNodes: 0, activeNode: 1)
                    .frame(alignment: .top)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.ignoresSafeArea(edges: .top))
                    .frame(maxWidth: .infinity)

                ScrollView {
                    VStack {
                        HStack {
                            Text("Account Set-Up")
                                .font(.custom("Metropolis-Regular", size: 34))
                                .foregroundColor(Color("NeutralGray3"))
                                .frame(width: 306, height: 41)
                            Spacer()
                        }
                        .padding(.bottom, 32)
                        .padding(.top, 8)

                        InputValidationComponent(text: $viewModel.account.email, componentName: Text("Email: ")
                            .font(.custom("Metropolis-Regular", size: 16)), labelText: "Email", showCheck: true,
                                                 functions: viewModel.emailFunc)
                            .padding(.bottom, 32)

                        InputValidationComponent(text: $viewModel.account.name, componentName: Text("Name: ")
                            .font(.custom("Metropolis-Regular", size: 16)), labelText: "Name")
                            .padding(.bottom, 32)

                        InputValidationComponent(text: $viewModel.account.password, componentName: Text("Password: ")
                            .font(.custom("Metropolis-Reegular", size: 16)), labelText: "Password", isSecured: true,
                                                 showEye: true, showCheck: true, functions: viewModel.passFunc)
                            .padding(.bottom, 32)

                        InputValidationComponent(
                            text: $viewModel.passwordAgain,
                            componentName: Text("Confirm Password: ").font(.custom("Metropolis-Regular", size: 16)),
                            labelText: "Password",
                            isSecured: true,
                            showEye: true,
                            functions: viewModel.passAgainFunc
                        )
                        .padding(.bottom, 32)
                    }
                }

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
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 32)
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
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationBarItems(leading: NavigationLink(
            destination: LoginPageView(),
                label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Login")
                            .font(.custom("Metropolis-Regular", size: 13))
                    }
                }
            )
        )
        .navigationBarTitle(Text("Sign-Up").font(.custom("Metropolis-Regular", size: 17)), displayMode: .inline)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.emailFunc = [SignUpFlowErrorFunctions.IUSDEmail]
            viewModel.passFunc = [SignUpFlowErrorFunctions.EightChars,
                                  SignUpFlowErrorFunctions.OneNumber,
                                  SignUpFlowErrorFunctions.SpecialChar]
        }
    }
}

struct SignUpSetUpScreen_Previews: PreviewProvider {
    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpSetUpScreen(viewModel: viewModel)
    }
}
