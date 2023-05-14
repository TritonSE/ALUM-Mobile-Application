//
//  CustomTabView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/1/23.
//

import SwiftUI

struct ProfileRouter: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        NavigationView {
            Group {
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
    }
}

struct PlaceHolderHomeScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("PlaceHolderHomeScreen")
                Button("Sign Out", action: {
                    FirebaseAuthenticationService.shared.logout()
                })
            }
        }
    }
}

struct LoggedInRouter: View {
    // (todo) Needs to be customized to match our design
    @State private var selection = 0
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.white) // custom color.
    }

    let tabItems = [
            TabBarItem(iconName: "ALUM Home", title: "Home"),
            TabBarItem(iconName: "GrayCircle", title: "Profile")
        ]

    var body: some View {
        VStack(spacing: 0) {
            switch selection {
            case 0:
                PlaceHolderHomeScreen()
            case 1:
                ProfileRouter()
            default:
                Text("Error")
            }
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    ForEach(0..<tabItems.count) { index in
                        VStack(spacing: 0) {
                            if index == selection {
                                Rectangle()
                                    .frame(width: 64, height: 3)
                                    .foregroundColor(Color("ALUM Primary Purple"))
                            } else {
                                Rectangle()
                                    .frame(width: 64, height: 2)
                                    .foregroundColor(.white)
                            }
                            Button(action: {
                                selection = index
                            }, label: {
                                VStack(spacing: 4) {
                                    Image( tabItems[index].iconName)
                                        .font(.system(size: 20))
                                    Text(tabItems[index].title)
                                        .font(.custom("Metropolis-Regular", size: 10, relativeTo: .footnote))
                                }
                                .foregroundColor(Color("ALUM Primary Purple"))
                                .frame(maxWidth: .infinity)
                            })
                            .padding(.top, 15)
                        }
                    }
                }
                .frame(height: 45)
            }

                }
    }

}

struct TabBarItem {
    let iconName: String
    let title: String
}

struct LoggedInRouter_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInRouter()
    }
}
