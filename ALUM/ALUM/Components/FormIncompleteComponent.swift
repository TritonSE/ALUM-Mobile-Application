//
//  FormIncompleteComponent.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import SwiftUI

struct FormIncompleteComponent: View {
    @State var type: String = "Pre"

    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(Color("FunctionalError"))

                Text(type + "-session form incomplete")
                    .font(.custom("Metropolis-Regular", size: 13, relativeTo: .headline))
                    .foregroundColor(Color("FunctionalError"))
            }
            .padding(5.0)
            .background {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(Color("FunctionalError").opacity(0.12))
            }
        }
    }
}

struct FormIncompleteComponent_Previews: PreviewProvider {
    static var previews: some View {
        FormIncompleteComponent()
    }
}
