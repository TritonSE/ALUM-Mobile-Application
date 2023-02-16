//
//  ProgressBarComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/25/23.
//

// nodeList - [completed, not completed, completed...]

import SwiftUI

struct ProgressBarComponent: View {
    @State var nodes = 6
    @State var filledNodes = 3
    @State var activeNode = 3

    var body: some View {
        GeometryReader { (geometry) in
            self.makeView(geometry)
        }.fixedSize(horizontal: false, vertical: true)
    }

    func makeView(_ geometry: GeometryProxy) -> some View {
        let equalWidth = geometry.size.width / CGFloat(self.nodes)

        return ZStack {
            HStack(spacing: 0) {
                ForEach(0 ..< nodes - 1, id: \.self) { index in
                    if index < activeNode-1 || index < filledNodes - 1 {
                        Rectangle()
                            .frame(width: .infinity, height: 2)
                            .foregroundColor(Color("ALUM Dark Blue"))
                    } else {
                        Rectangle()
                            .frame(width: .infinity, height: 2)
                            .foregroundColor(Color("NeutralGray2"))
                    }
                }
            }
            .padding(.horizontal, equalWidth/2)

            HStack(spacing: 0) {
                ForEach(0 ..< nodes, id: \.self) { index in
                    if index == activeNode - 1 {
                        Circle()
                            .strokeBorder(Color("ALUM Dark Blue"), lineWidth: 3)
                            .background(Circle().foregroundColor(Color("ALUM Light Blue")))
                            .frame(width: equalWidth, height: 16)
                    } else if index < filledNodes {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("ALUM Dark Blue"))
                                .frame(width: equalWidth, height: 16)

                            Image("CheckMarkVector")
                        }
                    } else {
                        Circle()
                            .foregroundColor(Color("NeutralGray2"))
                            .frame(width: equalWidth, height: 16)
                    }
                }
            }
        }
    }
}

struct ProgressBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressBarComponent()
        }

    }
}
