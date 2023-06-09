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
                .foregroundColor(Color("ALUM Primary Purple"))
                .font(.headline)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color( "ALUM Primary Purple"), lineWidth: 2)
                )
                .cornerRadius(8)
        } else {
            configuration.label
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 48)
                .foregroundColor(Color("NeutralGray4"))
                .font(.headline)
                .background(Color(
                    "NeutralGray1"))
                .cornerRadius(8)
                .disabled(true)
        }

    }
}

struct OutlinedButtonView: View {
    var body: some View {
        HStack(spacing: 10) {
            Button("OUTLINED BUTTON") {

            }
            .frame(minWidth: 50, maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            .buttonStyle(OutlinedButtonStyle(disabled: false))
            Button("DISABLED BUTTON") {

            }
            .disabled(true)
            .frame(minWidth: 50, maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            .buttonStyle(OutlinedButtonStyle(disabled: true))
        }
        .padding(15)
    }

}

struct OutlinedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        OutlinedButtonView()
    }
}
