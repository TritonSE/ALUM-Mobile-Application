//
//  CustomNavBarContainerView.swift
//  ALUM
//
//  Created by Yash Ravipati on 5/18/23.
//

import SwiftUI

struct CustomNavBarDefaultValues {
    static var showBackButton: Bool = true
    static var title: String = ""
    static var barIsPurple: Bool = false
    static var barIsHidden: Bool = false
}

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    
    // By default, we show the back button unless some view explicitly sets 
    // this to false
    @State private var showBackButton: Bool = CustomNavBarDefaultValues.showBackButton 
    
    @State private var title: String = CustomNavBarDefaultValues.title
    @State private var isPurple: Bool = CustomNavBarDefaultValues.barIsPurple
    @State private var isHidden: Bool = CustomNavBarDefaultValues.barIsHidden
    
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        return VStack(spacing: 0) {
            if !isHidden {
                CustomNavBarView(showBackButton: showBackButton, title: title, isPurple: isPurple)
            }
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
        .onPreferenceChange(CustomNavBarIsHiddenPreferenceKey.self, perform: {
            value in
            self.isHidden = value
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
