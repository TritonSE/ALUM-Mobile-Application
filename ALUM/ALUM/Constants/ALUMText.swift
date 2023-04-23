//
//  File.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/23/23.
//

import SwiftUI

enum ALUMFontName: String {
    case bodyFontName = "Metropolis-Regular"
}

enum ALUMFontSize: CGFloat {
    case smallFontSize = 13
    case bodyFontSize = 17
    case largeFontSize = 34
}

struct ALUMText: View {
    let text: String
    let fontName: ALUMFontName
    let fontSize: ALUMFontSize
    let isUnderlined: Bool

    init(text: String, fontName: ALUMFontName = .bodyFontName, fontSize: ALUMFontSize = .bodyFontSize, isUnderlined: Bool = false) {
       self.text = text
       self.fontName = fontName
       self.fontSize = fontSize
       self.isUnderlined = isUnderlined
   }

    var body: some View {
        Text(text)
            .font(.custom(fontName.rawValue, size: fontSize.rawValue))
            .underline(isUnderlined)
    }
}
