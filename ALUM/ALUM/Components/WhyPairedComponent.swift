//
//  WhyPairedComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/8/23.
//

import SwiftUI

struct WhyPairedComponent: View {
    @State var active = false
    @State var text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit,
    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    """
    var body: some View {
        VStack(spacing: 0) {
            Button {
                active.toggle()
            } label: {
                ZStack {
                    Text("Why were you paired?")
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    if active {
                        Image(systemName: "chevron.up")
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .frame(width: 12, height: 6)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 21)
                        Rectangle()
                            .stroke(Color("ALUM Light Purple"), lineWidth: 2)
                            .cornerRadius(12.0, corners: .topLeft)
                            .cornerRadius(12.0, corners: .topRight)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .frame(width: 12, height: 6)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 21)
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("ALUM Light Purple"), lineWidth: 2)
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(height: 48)
            if active {
                Text(text)
                    .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    .padding(.leading, 16)
                    .padding(.trailing, 32)
                    .padding(.vertical, 15)
                    .background(
                        Rectangle()
                            .stroke(Color("ALUM Light Purple"), lineWidth: 2)
                            .frame(minHeight: 0, alignment: .top)
                            .foregroundColor(.white)
                            .cornerRadius(12.0, corners: .bottomLeft)
                            .cornerRadius(12.0, corners: .bottomRight)
                            .frame(width: 358)
                        )
            }
        }
        .frame(width: 358)
    }
}

struct WhyPairedComponent_Previews: PreviewProvider {
    static var previews: some View {
        WhyPairedComponent()
    }
}
