//
//  TagDisplay.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 2/20/23.
//

import SwiftUI

struct TagDisplay: View {

    @State var text: String = ""
    @State var isShowing: Bool = true

    var body: some View {
        VStack {
            ZStack {
                HStack {

                    Text(text)
                        .foregroundColor(Color(.black))
                    Spacer()
                        .frame(width: 10)

                    Button(action: {
                        isShowing = false
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .foregroundColor(Color("NeutralGray4"))
                    .frame(height: 8)
                    .frame(width: 8)

                }

            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 100).stroke())
            .foregroundColor(Color("ALUM Light Blue"))
            .font(.body)
            .background(Color("ALUM Light Blue"))
            .cornerRadius(100)

        }
    }
}

struct TagDisplay_Previews: PreviewProvider {
    static var previews: some View {
        TagDisplay(text: "Sample New Text @12345")
    }
}
