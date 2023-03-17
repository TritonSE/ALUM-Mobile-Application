//
//  FirebaseContentView.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/17/23.
//

import SwiftUI

struct FirebaseContentView: View {
    @State var toShow: String = "sign up"
    @EnvironmentObject private var authModel: FirebaseAuthenticationService

    var body: some View {
        //how to get IDToken to send to backend
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

struct FirebaseContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseContentView()
    }
}
