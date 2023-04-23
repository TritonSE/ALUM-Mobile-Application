//
//  InputValidationText.swift
//  ALUM
//
//  Created by Harsh Gurnani on 1/25/23.
//

import SwiftUI

struct InputValidationText: View {

    @State var isValid: Bool = false
    @State var message: String = "message"
    @State var showCheck: Bool = true

    var body: some View {
        let messageIconSystemName = isValid ?  "checkmark.circle" : "exclamationmark.circle"
        let color = isValid ? ALUMColor.green : ALUMColor.red
        return HStack {
            if showCheck {
                Image(systemName: messageIconSystemName)
            }

            ALUMText(text: message, fontSize: .smallFontSize, textColor: color)
                .frame(height: 18.0)

            Spacer()
        }
        .foregroundColor(color.color)
        .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
    }
}

struct InputValidationText_Previews: PreviewProvider {
    static var previews: some View {
        InputValidationText(isValid: true)
        InputValidationText(isValid: false)
    }
}
