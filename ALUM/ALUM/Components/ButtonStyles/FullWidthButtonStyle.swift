//
//  FullWidthButtonStyle.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/28/23.
//

import SwiftUI

struct FullWidthButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(ALUMColor.white.color)
        }
}

struct FullWidthButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            print("out")
        }, label: {
            HStack {
                ALUMText(text: "Log out", textColor: ALUMColor.red)
                Image("Logout Icon")
            }
        })
        .buttonStyle(FullWidthButtonStyle())
    }
}
