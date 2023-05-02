//
//  CustomTabView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/1/23.
//

import SwiftUI

struct ProfileRouter: View {
    @ObservedObject var currentUser: CurrentUserModal = CurrentUserModal.shared

    var body: some View {
        switch self.currentUser.role {
        case .some(UserRole.mentor):
            MentorProfileScreen(uID: self.currentUser.uid!)
        case .some(UserRole.mentee):
            MenteeProfileScreen(uID: self.currentUser.uid!)
        case .none:
            Text("Internal Error: User Role is nil")
        }
    }
}

struct PlaceHolderHomeScreen: View {
    var body: some View {
        VStack {
            Text("PlaceHolderHomeScreen")
            Button("Sign Out", action: {
                FirebaseAuthenticationService.shared.logout()
            })
        }
    }
}

struct ALUMTabView: View {
    // (todo) Needs to be customized to match our design
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            PlaceHolderHomeScreen()
                .tabItem {
                    Image("Home Tab Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 27)
                        .foregroundColor(Color("ALUM Primary Purple"))
                    Text("Home")
                }
                .tag(0)

            ProfileRouter()
                .tabItem {
                    Image("Profile Tab Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 27)
                        .frame(width: 27, height: 27)
                    Text("Profile")
                }
                .tag(1)
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ALUMTabView()
    }
}
