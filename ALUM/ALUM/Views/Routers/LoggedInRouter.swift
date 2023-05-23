//
//  CustomTabView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/1/23.
//

import SwiftUI

struct ProfileTabRouter: View {
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

struct HomeTabRouter: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        CustomNavView {
            if currentUser.upcomingSessionId == nil {
                HomeScreen()
            } else {
                SessionDetailsScreen(sessionId: currentUser.upcomingSessionId!)
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
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared
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
        Group {
            if currentUser.status == "under review" {
                if currentUser.role == .mentee {
                    LoginReviewPage(text:
                                        ["Application is under review",
                                           "It usually takes 3-5 days to process your application as a mentee."])
                } else if currentUser.role == .mentor {
                    LoginReviewPage(text:
                                        ["Application is under review",
                                           "It usually takes 3-5 days to process your application as a mentor."])
                }
            } else if currentUser.status == "approved" {
                if currentUser.role == .mentee {
                    LoginReviewPage(text:
                                        ["Matching you with a mentor",
                                           "We are looking for a perfect mentor for you. Please allow us some time!"])
                } else if currentUser.role == .mentor {
                    LoginReviewPage(text:
                                        ["Matching you with a mentee",
                                           "We are looking for a perfect mentee for you. Please allow us some time!"])
                }
            } else {
                pairedUserView
            }
        }
    }

    // once user is approved and paired
    var pairedUserView: some View {
        VStack(spacing: 0) {
            switch selection {
            case 0:
                HomeTabRouter()
                    .onAppear(perform: {
                        currentUser.showTabBar = true
                    })
            case 1:
                ProfileTabRouter()
                    .onAppear(perform: {
                        currentUser.showTabBar = true
                    })
            default:
                Text("Error")
            }
            if currentUser.showTabBar {
                tabsDisplay
            }
        }
    }
    
    var tabsDisplay: some View {
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

struct TabBarItem {
    let iconName: String
    let title: String
}

struct LoggedInRouter_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInRouter()
    }
}
