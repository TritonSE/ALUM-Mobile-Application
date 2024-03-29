//
//  CustomNavBarPreferenceKeys.swift
//  ALUM
//
//  Created by Yash Ravipati on 5/18/23.
//

import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = CustomNavBarDefaultValues.title

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarIsHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = CustomNavBarDefaultValues.barIsHidden

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct CustomNavBarIsPurplePreferenceKey: PreferenceKey {
    static var defaultValue: Bool = CustomNavBarDefaultValues.barIsPurple

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct CustomNavBarBackHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = !CustomNavBarDefaultValues.showBackButton

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    func customNavigationIsHidden(_ isHidden: Bool) -> some View {
        preference(key: CustomNavBarIsHiddenPreferenceKey.self, value: isHidden)
    }

    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }

    func customNavigationIsPurple(_ isPurple: Bool) -> some View {
        preference(key: CustomNavBarIsPurplePreferenceKey.self, value: isPurple)
    }

    func customNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: CustomNavBarBackHiddenPreferenceKey.self, value: hidden)
    }

    func customNavBarItems(title: String, isPurple: Bool, backButtonHidden: Bool) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationIsPurple(isPurple)
            .customNavigationBarBackButtonHidden(backButtonHidden)
    }
}
