//
//  FilledButton.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/18/23.
//

import SwiftUI

struct FilledInButton : ButtonStyle{
    
    @State var isLarge: Bool = false
    @State var disabled: Bool = false
    
    var largeWidth = 358.0
    var smallWidth = 104.0
    
    func makeBody(configuration: Configuration) -> some View {
            if(!disabled){
                configuration.label
                    .frame(width: isLarge ? largeWidth : smallWidth)
                    .frame(height: 48)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .medium))
                    .background(Color("ALUM Dark Blue"))
                    .cornerRadius(8)
            }
            else{
                configuration.label
                    .frame(height: 48)
                    .frame(width: isLarge ? largeWidth : smallWidth)
                    .foregroundColor(Color("NeutralGray4"))
                    .font(.system(size: 17, weight: .medium))
                    .background(Color("NeutralGray1"))
                    .cornerRadius(8)
                    .disabled(true)
            }
        }
}

struct FilledButton: View {
    
    var body: some View {
        Button("Button") {
            
        }
        .buttonStyle(FilledInButton(isLarge: true, disabled: false))
    }
}

struct FilledButton_Previews: PreviewProvider {
    static var previews: some View {
        FilledButton()
    }
}


