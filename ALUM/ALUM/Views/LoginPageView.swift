//
//  LoginPageView.swift
//  ALUM
//
//  Created by Harsh Gurnani on 1/31/23.
//

import SwiftUI
import Firebase

struct LoginPageView: View {
    @State var email: String = ""
    @State var password: String = ""
    // @State var clicked: Bool = false
    @State var disabled: Bool = true
    @State private var userIsLoggedIn: Bool = false
    @State var emailFunc: [(String) -> (Bool, String)] = []
    @State var passFunc: [(String) -> (Bool, String)] = []
    
    // @State var buttonFilled: Bool = false

    var body: some View {
        if userIsLoggedIn {
            ContentView()
        } else {
            content
        }
    }
    
    var content: some View {
        /*
        emailFunc = (clicked ? [Functions.EnterEmail] : [])
        passFunc = (clicked ? [Functions.EnterPassword] : [])
         */
        
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

            InputValidationComponent(text: $email, componentName: Text("Email: ")
                .font(.custom("Metropolis-Regular", size: 16)), labelText: "Email", showCheck: false,
                functions: emailFunc)
                .padding(.bottom, 22)

            Group {
                InputValidationComponent(text: $password, componentName: Text("Password: ").font(.custom("Metropolis-Regular",size: 16)), labelText: "Password",
                    isSecured: true, showEye: true, showCheck: false, functions: passFunc)
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

            if email != "" && password != "" {
                Button("Login") {
                    // clicked = false
                    emailFunc = []
                    login()
                }
                .buttonStyle(FilledInButtonStyle(disabled: false))
                .frame(width: 358)
                .padding(.bottom, 32)
            } else {
                Button("Login") {
                    emailFunc = [Functions.EnterEmail]
                    passFunc = [Functions.EnterPassword]
                }
                .buttonStyle(FilledInButtonStyle(disabled: true))
                .frame(width: 358)
                .padding(.bottom, 32)
            }

        }
        /*
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
         */
        
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let maybeError = error {
                let errorCode = AuthErrorCode.Code(rawValue: maybeError._code)
                if (errorCode == .invalidEmail) {
                    print("Invalid Email")
                    emailFunc = [Functions.InvalidEmail]
                } else if (errorCode == .wrongPassword) {
                    print("wrong password")
                    passFunc = [Functions.IncorrectPassword]
                } else if (errorCode == .userNotFound) {
                    print("User not found")
                    emailFunc = [Functions.IncorrectEmail]
                }
                
                /*
                let err = maybeError as NSError
                        switch err.code {
                        case AuthErrorCode.wrongPassword.rawValue:
                            print("wrong password")
                        case AuthErrorCode.invalidEmail.rawValue:
                            print("invalid email")
                        case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                            print("accountExistsWithDifferentCredential")
                        default:
                            print("unknown error: \(err.localizedDescription)")
                        }
                 */
                // if error != nil {
                // print(error?.localizedDescription ?? "")
            } else {
                print("success")
                userIsLoggedIn.toggle()
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

    static let IncorrectPassword: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        return (false, "Incorrect Password")
    }

    static let IncorrectEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        return (false, "Account doesn't exist for this email")
    }

    static let InvalidEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        return (false, "Please enter a valid email address")
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
