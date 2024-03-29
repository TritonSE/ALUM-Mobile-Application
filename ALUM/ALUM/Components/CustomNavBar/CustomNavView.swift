//
//  CustomNavView.swift
//  ALUM
//
//  Created by Yash Ravipati on 5/18/23.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            MentorProfileScreen(uID: "6431b9a2bcf4420fe9825fe5")
                .customNavigationTitle("Title 2")
                .customNavigationBarBackButtonHidden(false)
        }
    }
}
