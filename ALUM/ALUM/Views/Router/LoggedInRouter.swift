//
//  LoggedInRouter.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/14/23.
//

import SwiftUI

struct LoggedInRouter: View {
    @State var page: FooterTabs = .profile
    
    var body: some View {
        VStack {
            if page == .home {
                Spacer()
                Text("Sessions Detail Page")
                Spacer()
            } else if page == .profile {
                MenteeProfileView()
                  .environmentObject(FirebaseAuthenticationService())
            }
            NavigationFooter(page: $page)
        }
    }
}

struct LoggedInRouter_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInRouter()
    }
}
