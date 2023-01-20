//
//  FilledInButtonStyle.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/20/23.
//

import SwiftUI

struct FilledInButtonStyle : ButtonStyle{
    @State var disabled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
            if(!disabled){
                configuration.label
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .font(.headline)
                    .background(Color("ALUM Dark Blue"))
                    .cornerRadius(8)
            }
            else{
                configuration.label
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .foregroundColor(Color("NeutralGray4"))
                    .font(.headline)
                    .background(Color("NeutralGray1"))
                    .cornerRadius(8)
                    .disabled(true)
            }
        }
}
struct FilledInButton: View {
    var body: some View {
        HStack(spacing: 10){
            Button("BUTTON") {
                
            }
            .frame(minWidth: 50,maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            .buttonStyle(FilledInButtonStyle(disabled: false))
            Button("BUTTON") {
                
            }
            .frame(minWidth: 50,maxWidth: 300, alignment: .leading)
            .frame(minHeight: 0, maxHeight: 48)
            .buttonStyle(FilledInButtonStyle(disabled: true))
        }
        .padding(15)
    }
}

struct FilledInButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        FilledInButton()
    }
}
