//
//  PlusButtonComponent.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 2/21/23.
//

import SwiftUI

struct PlusButtonComponent: View {
    var body: some View {
        Button(action: {
            // Action to be performed when the button is tapped
        }, label: {
            ZStack {
                Circle()
                    .foregroundColor(Color("ALUM Light Blue"))
                    .frame(width: 64, height: 64)
                Image(systemName: "plus")
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .frame(width: 14, height: 14)
            }
        })
    }
}

struct PlusButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonComponent()
    }
}
