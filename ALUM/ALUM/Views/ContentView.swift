//
//  ContentView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World")
                NavigationLink(destination: LoginPageView()) {
                    Text("Login Page")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
