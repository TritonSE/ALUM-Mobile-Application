//
//  CustomNavView.swift
//  ALUM
//
//  Created by Yash Ravipati on 5/18/23.
//

import SwiftUI

struct CustomNavView<Content:View>:  View {
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
        CustomNavView{
            LoginReviewPage(text: ["Hello", "Hi"])
                .customNavigationTitle("Title 2")
                .customNavigationBarBackButtonHidden(false)
        }
    }
}
