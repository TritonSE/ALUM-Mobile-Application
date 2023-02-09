//
//  LoginPageView.swift
//  ALUM
//
//  Created by Harsh Gurnani on 1/31/23.
//

import SwiftUI
// import Firebase

struct LoginPageView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var clicked: Bool = false
    // @State var buttonFilled: Bool = false

    var body: some View {
        var emailFunc: [(String) -> (Bool, String)] = (clicked ? [Functions.EnterEmail] : [])
        var passFunc: [(String) -> (Bool, String)] = (clicked ? [Functions.EnterPassword] : [])
        var disabled: Bool = ((email == "" || password == "") ? true : false)

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

            InputValidationComponent(text: $email, componentName: Text("Email: ")
                .font(.custom("Metropolis-Regular", size: 16)), labelText: "Email", showCheck: false,
                functions: emailFunc)
                .padding(.bottom, 22)

            Group {
                InputValidationComponent(text: $password, componentName: Text("Password: ").font(.custom("Metropolis-Regular",size: 16)), labelText: "Password",
                    isSecured: true, showEye: true, showCheck: false, functions: passFunc)
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

            Button("Login") {
                clicked = true
            }
            .buttonStyle(FilledInButtonStyle(disabled: disabled))
            .frame(width: 358)
            .padding(.bottom, 32)

            /*
            if email != "" && password != "" {
                Button("Login") {
                    clicked = true
                    // login()
                }
                .buttonStyle(FilledInButtonStyle(disabled: false))
                .frame(width: 358)
                .padding(.bottom, 32)
            } else {
                Button("Login") {
                    clicked = true
                }
                .buttonStyle(FilledInButtonStyle(disabled: true))
                .frame(width: 358)
                .padding(.bottom, 32)
            }
             */

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

    /*
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
     */
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
