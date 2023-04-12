//
//  NavigationHeaderComponent.swift
//  ALUM
//
//  Created by Aman Aggarwal on 3/17/23.
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
    var body: some View {
        ZStack {
            Group {
                if #available(iOS 16.0, *) {
                    // Apply function that is only available in iOS 16 or later
                    NavigationLink(destination: backDestination, label: {BackButton(text: backText)})
                        .toolbar(.hidden, for: .navigationBar)
                } else {
                    // Apply function that is available in earlier versions of iOS
                    // Because .navigationBarHidden is deprecated in future versions of iOS
                    NavigationLink(destination: backDestination, label: {BackButton(text: backText)})
                            .navigationBarHidden(true)
                }
            }
            .foregroundColor(Color("ALUM Dark Blue"))
            .frame(maxWidth: .infinity, alignment: .leading)
            Text(title)
                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

struct NavigationHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderComponent(
            backText: "Login",
            backDestination: LoginPageView(),
            title: "Signup"
        )
    }
}
