//
//  NavigationComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/10/23.
//

import SwiftUI

struct BackButton: View {
    @State var text: String
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .frame(width: 6, height: 12)
            Text(text)
                .font(.custom("Metropolis-Regular", size: 13, relativeTo: .footnote))
        }
    }
}

struct NavigationHeaderComponent<Destination: View>: View {
    @State var backText: String
    @State var backDestination: Destination
    @State var title: String
    @State var purple: Bool
    @State var showButton = true
    @State var showAlert = false

    @State var doesNagivate = false
    var body: some View {
        let foreColor = purple ? Color("ALUM White") : Color("ALUM Primary Purple")
        let titleColor = purple ? Color("ALUM White") : Color.black
        ZStack {
            if showButton {
                Group {
                    if #available(iOS 16.0, *) {
                        // Apply function that is only available in iOS 16 or later
                        Button(action: {
                            showAlert = true
                        }, label: {BackButton(text: "Login")})
                        NavigationLink(destination: backDestination,
                                       isActive: $doesNagivate,
                                       label: {BackButton(text: backText)})
                            .alert(isPresented: $showAlert) {
                                Alert(
                                            title: Text("Exit sign-up?"),
                                            message: Text("Your sign-up form will not be saved."),
                                            primaryButton: .destructive(
                                                Text("Exit"),
                                                action: {
                                                    doesNagivate = true
                                                }
                                            ),
                                            secondaryButton: .cancel(
                                                Text("No"),
                                                action: {
                                                    showAlert = false
                                                }
                                            )
                                        )
                            }
                            .hidden()
                            .toolbar(.hidden, for: .navigationBar)
                    } else {
                        // Apply function that is available in earlier versions of iOS
                        // Because .navigationBarHidden is deprecated in future versions of iOS

//                        Button(action: {
//                            showAlert = true
//                        }, label: {BackButton(text: "Login")})
//                        NavigationLink(destination: backDestination,
//                                       isActive: $doesNagivate,
//                                       label: {BackButton(text: backText)})
//                            .alert(isPresented: $showAlert) {
//                                Alert(
//                                            title: Text("Exit sign-up?"),
//                                            message: Text("Your sign-up form will not be saved."),
//                                            primaryButton: .destructive(
//                                                Text("Exit"),
//                                                action: {
//                                                    doesNagivate = true
//                                                }
//                                            ),
//                                            secondaryButton: .cancel(
//                                                Text("No"),
//                                                action: {
//                                                    showAlert = false
//                                                }
//                                            )
//                                        )
//                            }
//                            .hidden()
//                            .navigationBarHidden(true)
//                            .toolbar(.hidden, for: .navigationBar)

                        NavigationLink(destination: backDestination, label: {BackButton(text: backText)})
                            .navigationBarHidden(true)
                    }
                }
                .foregroundColor(foreColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text(title)
                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(titleColor)
        }
        .padding()
    }
}

struct NavigationHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderComponent(
            backText: "Login",
            backDestination: LoginScreen(),
            title: "Signup",
            purple: false
        )
    }
}
