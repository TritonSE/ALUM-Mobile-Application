//
//  CustomNavBarContainerView.swift
//  ALUM
//
//  Created by Yash Ravipati on 5/18/23.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    @State private var showBackButton: Bool = false
    @State private var title: String = ""
    @State private var isPurple: Bool = false
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        return VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, isPurple: isPurple)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: {
            value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarIsPurplePreferenceKey.self, perform: {
            value in
            self.isPurple = value
        })
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self, perform: {
            value in
            self.showBackButton = !value
        })
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            VStack(spacing: 0) {
                LoginReviewPage(text: ["Hello", "Hi"])
            }
        }
    }
}
