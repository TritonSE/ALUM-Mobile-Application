//
//  PasswordInputFieldComponent.swift
//  ALUM
//
//  Created by Harsh Gurnani and Sidhant Rohatgi on 1/18/23.
//

import SwiftUI

struct PasswordInputFieldComponent: View {
    
    @State var password: String = ""
    @State private var isSecured: Bool = true
    @State private var showEye: Bool = true
    
    var body: some View {
        
        ZStack (alignment: .trailing){
            Group {
                if isSecured {
                    SecureField("Password", text: $password)
                } else {
                    TextField("Password", text: $password)
                }
            }
            .padding(16.0)
            .frame(height: 48.0)
            .background(
                Color("ALUM White")
                    .cornerRadius(8.0)
            )
            .overlay (
                RoundedRectangle(cornerRadius: 8.0).stroke(Color("Neutral/Gray3"), lineWidth: 1.0)
            )
            
            if showEye {
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                        .accentColor(Color("Neutral/Gray4"))
                }
                .padding(14.0)
            }
            
        }
        .padding()
        
    }
}

struct Previews_PasswordInputFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputFieldComponent()
    }
}
