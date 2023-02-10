//
//  LoginPageView.swift
//  ALUM
//
//  Created by Harsh Gurnani on 1/31/23.
//

import SwiftUI

struct LoginPageView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var clicked: Bool = false
    // @State var buttonFilled: Bool = false

    var body: some View {
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

            if clicked {
                InputValidationComponent(text: $username, componentName: Text("Email: ").font(.custom("Metropolis-Regular", size: 16)),
                    labelText: "Email", showCheck: false, functions: [Functions.EnterEmail])
                    .padding(.bottom, 12)

                Group {
                    InputValidationComponent(text: $password, componentName: Text("Password: ").font(.custom("Metropolis-Regular",size: 16)),
                        labelText: "Password", showCheck: false, functions: [Functions.EnterPassword])
                        .padding(.bottom, 0)

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

            } else {
                InputValidationComponent(text: $username, componentName: Text("Email: "), labelText: "Email", showCheck: false)
                    .padding(.bottom, 32)

                Group {
                    InputValidationComponent(text: $password, componentName: Text("Password: "), labelText: "Password", showCheck: false)

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

            }

            if username != "" && password != "" {
                Button("Login") {
                    clicked.toggle()
                }
                .buttonStyle(FilledInButtonStyle(disabled: false))
                .frame(width: 358)
                .padding(.bottom, 32)
            } else {
                Button("Login") {
                    clicked.toggle()
                }
                .buttonStyle(FilledInButtonStyle(disabled: true))
                .frame(width: 358)
                .padding(.bottom, 32)
            }

        }
    }
}

class Functions {
    static let EnterEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        if string == "" {
            return (false, "Please enter your email")
        } else {
            return (false, "skip")
        }
    }

    static let EnterPassword: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        if string == "" {
            return (false, "Please enter your password")
        } else {
            return (false, "skip")
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
