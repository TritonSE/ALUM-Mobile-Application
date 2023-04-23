//
//  OutlinedButtonStyle.swift
//  ALUM
//
//  Created by Jenny Mar on 1/20/23.
//

import SwiftUI

struct OutlinedButtonStyle: ButtonStyle {

    @State var disabled: Bool = false

    func makeBody(configuration: Configuration) -> some View {

        if !disabled {
            configuration.label
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 48)
                .foregroundColor(ALUMColor.primaryPurple.color)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(ALUMColor.primaryPurple.color, lineWidth: 2)
                )
                .cornerRadius(8)
        } else {
            configuration.label
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 48)
                .foregroundColor(ALUMColor.gray4.color)
                .background(ALUMColor.gray1.color)
                .cornerRadius(8)
                .disabled(true)
        }

    }
}

struct OutlinedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            Button("OUTLINED BUTTON") {

            }
            .frame(minWidth: 50, maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            .buttonStyle(OutlinedButtonStyle(disabled: false))
            Button("DISABLED BUTTON") {

            }
            .frame(minWidth: 50, maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            .buttonStyle(OutlinedButtonStyle(disabled: true))
        }
        .padding(15)
    }
}
