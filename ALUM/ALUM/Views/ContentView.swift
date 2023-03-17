//
//  ContentView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @State var toShow: String = "sign up"
    @EnvironmentObject private var authModel: FirebaseAuthenticationService

    var body: some View {
        if authModel.user != nil {
            authModel.user?.getIDToken { (token, error) in
                    if let error = error {
                        // Handle error
                        print("Error getting ID token: \(error.localizedDescription)")
                    } else {
                        // Use the ID token
                        print("ID token: \(token ?? "")")
                    }
                }
        }
        return
        Group {
            if authModel.user != nil {
                VStack {
                    Button("Signout") {
                        authModel.signOut()
                    }
                }
            } else {
                LoginPageView()
            }
            }.onAppear {
                authModel.listenToAuthState()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
