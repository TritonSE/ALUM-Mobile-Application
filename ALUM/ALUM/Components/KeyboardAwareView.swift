//
//  KeyboardAwareView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 6/9/23.
//
import SwiftUI

struct KeyboardAwareView<Content: View>: View {
    let content: Content
    @State private var keyboardHeight: CGFloat = 0

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(.bottom, keyboardHeight)
            .edgesIgnoringSafeArea(keyboardHeight > 0 ? .bottom : [])
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillShowNotification
                )) { notification in
                guard let keyboardSize = notification.userInfo?[
                    UIResponder.keyboardFrameEndUserInfoKey
                ] as? CGRect else { return }
                keyboardHeight = keyboardSize.height
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                keyboardHeight = 0
            }
    }
}
