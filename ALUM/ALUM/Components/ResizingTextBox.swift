//
//  ResizingTextBox.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/14/23.
//

import SwiftUI

struct ResizingTextBox: View {
    @Binding var text: String

    var body: some View {
        VStack {
            if text.count <= 150 {
                HStack {
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(.black)
                            .lineSpacing(4.0)
                            .padding(.top, 16)
                            .padding(.bottom, 8)

                        Spacer()
                    }

                    Spacer()
                }
                .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                .frame(height: 120.0)
                .background(
                    Color("ALUM White")
                        .cornerRadius(8.0)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
                )
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(.black)
                            .truncationMode(.tail)
                            .lineSpacing(4.0)
                            .padding(.top, 16)
                            .padding(.bottom, 8)

                        Spacer()
                    }

                    Spacer()
                }
                .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                .frame(height: 172.0)
                .background(
                    Color("ALUM White")
                        .cornerRadius(8.0)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
                )
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}

struct ResizingTextBox_Previews: PreviewProvider {
    static var text = Binding.constant("Hello World")

    static var previews: some View {
        ResizingTextBox(text: text)
    }
}
