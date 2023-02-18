//
//  Tags.swift
//  ALUM
//
//  Created by Jenny Mar on 1/28/23.
//

import SwiftUI

struct Tags: View {

    @State var text: String = ""
    @State var isBlue: Bool = true
    @State var isShowing: Bool = true

    var body: some View {
        if isBlue {
            VStack {
                ZStack {
                    HStack {

                        Text(text)
                            .foregroundColor(Color(.black))
                        Spacer()
                            .frame(width: 10)

                        Button(action: {
                            isShowing = true
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
                .foregroundColor(Color("Alum Light Blue"))
                .font(.body)
                .background(Color("Alum Light Blue"))
                .cornerRadius(100)

                }
        } else {
            VStack {
                ZStack {
                    HStack {
                        Button(action: {isShowing = true}, label: {
                            Spacer()
                                .frame(width: 18)

                            Image(systemName: "plus")
                                .foregroundColor(Color("ALUM Dark Blue"))

                            Spacer()
                                .frame(width: 14)

                            Text(text)
                                .foregroundColor(Color("ALUM Dark Blue"))
                            Spacer()
                                .frame(width: 12)
                        })
                    }

                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 100).stroke())
                .foregroundColor(Color("Alum Light Blue"))
                .font(.body)
                .background(Color(.white))
                .cornerRadius(100)

                }
        }

    }
}

struct Tags_Previews: PreviewProvider {
    static var previews: some View {
        Tags(text: "Sample Text @12345", isBlue: true)
        Tags(text: "Sample Text Blue @12345", isBlue: false)
    }
}
