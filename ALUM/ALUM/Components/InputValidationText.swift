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
        if isValid {
            HStack {
                if showCheck {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(Color("FunctionalSuccess"))
                }

                Text(message)
                    .foregroundColor(Color("FunctionalSuccess"))
                    .font(.subheadline)
                    .frame(height: 18.0)

                Spacer()
            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))

        } else {
            HStack {
                if showCheck {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(Color("FunctionalError"))
                        .frame(width: 16.0, height: 16.0)
                }

                Text(message)
                    .foregroundColor(Color("FunctionalError"))
                    .font(.subheadline)
                    .frame(height: 18.0)

                Spacer()
            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
        }
    }
}

struct InputValidationText_Previews: PreviewProvider {
    static var previews: some View {
        InputValidationText()
    }
}
