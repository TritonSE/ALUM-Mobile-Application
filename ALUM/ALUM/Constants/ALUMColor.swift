//
//  ALUMColors.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/23/23.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

enum ALUMColor: UInt {
    case lightBlue = 0xD0DBFF
    case primaryBlue = 0x4470FF

    case extraLightPurple = 0xEFEEFF
    case lightPurple = 0xD0CDFF
    case primaryPurple = 0x463EC7

    case red = 0xB93B3B
    case green = 0x3BB966

    case gray1 = 0xEBEBEB
    case gray2 = 0xD8D8D8
    case gray3 = 0xB4B4B4
    case gray4 = 0x909090

    case white = 0xFFFFFF
    case beige = 0xFCFAF6
    case black = 0x000000

    var color: Color {
        return Color(hex: self.rawValue)
    }
}

let primaryGradientColor = LinearGradient(
    gradient: Gradient(colors: [ALUMColor.primaryBlue.color, ALUMColor.primaryPurple.color]),
    startPoint: .bottomTrailing,
    endPoint: .topLeading
)
