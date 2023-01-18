//
//  TextInputFieldView.swift
//  ALUM
//
//  Created by Harsh Gurnani and Sidhant Rohatgi on 1/18/23.
//

import SwiftUI

struct TextInputFieldComponent: View {
    @State var textFieldText: String = ""
        
    var body: some View {
        
        VStack {
            TextField("Type something here...",
                      text: $textFieldText)
            .padding(16.0)
            .frame(height: 48.0)
            .background(
                Color("ALUM White")
                    .cornerRadius(8.0)
            )
            .overlay (
                RoundedRectangle(cornerRadius: 8.0).stroke(Color("Neutral/Gray3"), lineWidth: 1.0)
            )
            
        }
        .padding()
    }
}

struct TextInputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputFieldComponent()
    }
}
