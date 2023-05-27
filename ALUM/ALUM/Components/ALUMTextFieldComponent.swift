//
//  ALUMTextFieldComponent.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/15/23.
//

import SwiftUI

struct ALUMTextFieldComponent: View {
    @State var title: String = ""
    @State var suggestion: String = ""
    @Binding var text: String
    @State var isSecure = false

    var body: some View {
        VStack {
            HStack {
                Text(title).lineSpacing(4.0)
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.bottom, 2).padding(.leading, 16)

            Group {
                if isSecure {
                    SecureField(suggestion, text: $text)
                } else {
                    TextField(suggestion, text: $text)
                }
            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            .frame(height: 48.0)
            .background(Color("ALUM White").cornerRadius(8.0))
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color("NeutralGray3"), lineWidth: 1.0)
            )
            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
        }
    }
}

struct ALUMTextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        @State var text = "hello"
        return ALUMTextFieldComponent(text: $text)
    }
}
