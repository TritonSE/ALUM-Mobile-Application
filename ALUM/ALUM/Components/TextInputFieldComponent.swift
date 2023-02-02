//
//  TextInputFieldView.swift
//  ALUM
//
//  Created by Harsh Gurnani and Sidhant Rohatgi on 1/18/23.
//

import SwiftUI

struct TextInputFieldComponent: View {
    @State var textFieldText: String = ""
    @State var isSecured: Bool = false
    @State var showEye: Bool = false
    var labelText: String = ""

    var body: some View {

        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(labelText, text: $textFieldText)
                } else {
                    TextField(labelText, text: $textFieldText)
                }
            }
            .padding(16.0)
            .frame(height: 48.0)
            .background(
                Color("ALUM White")
                    .cornerRadius(8.0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
            )

            if showEye {
                Button(action: {
                    isSecured.toggle()
                })
                {
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                        .accentColor(Color("NeutralGray4"))
                }
                .padding(14.0)
            }

        }
        .padding()
    }
}

struct TextInputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputFieldComponent(isSecured: false, showEye: false, labelText: "Username:")
    }
}
