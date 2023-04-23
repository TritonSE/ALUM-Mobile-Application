//
//  FilledInButtonStyle.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/20/23.
//

import SwiftUI

struct FilledInButtonStyle: ButtonStyle {
    @State var disabled: Bool = false

    func makeBody(configuration: Configuration) -> some View {
            if !disabled {
                configuration.label
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 48)
                    .foregroundColor(.white)
                    .background(primaryGradientColor)
                    .cornerRadius(8)
            } else {
                configuration.label
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 48)
                    .foregroundColor(ALUMColor.gray4.color)
                    .background(ALUMColor.gray1.color)
                    .cornerRadius(8)
            }
        }
}

struct FilledInButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            Button("BUTTON") {

            }
            .frame(minWidth: 50, maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            
            .buttonStyle(FilledInButtonStyle(disabled: false))
            Button("BUTTON") {

            }
            .frame(minWidth: 50, maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            .buttonStyle(FilledInButtonStyle(disabled: true))
        }
        .padding(15)
    }
}
