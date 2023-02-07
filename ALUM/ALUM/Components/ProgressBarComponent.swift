//
//  ProgressBarComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/25/23.
//

// nodeList - [completed, not completed, completed...]

import SwiftUI

struct ProgressBarComponent: View {
    @State var nodes = 5
    @State var filledNodes = 4
    @State var activeNode = 2

    var body: some View {
        GeometryReader { (geometry) in
            self.makeView(geometry)
        }
    }

    func makeView(_ geometry: GeometryProxy) -> some View {
        let margin = geometry.size.width / CGFloat(self.nodes) - 16
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
            .frame(width: geometry.size.width - margin)

            HStack(spacing: 0) {
                ForEach(0 ..< nodes, id: \.self) { index in
                    if index == activeNode - 1 {
                        Circle()
                            .strokeBorder(Color("ALUM Dark Blue"), lineWidth: 3)
                            .background(Circle().foregroundColor(Color("ALUM Light Blue")))
                            .frame(width: .infinity, height: 16)
                    } else if index < filledNodes {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("ALUM Dark Blue"))
                                .frame(width: .infinity, height: 16)

                            Image("CheckMarkVector")
                        }
                    } else {
                        Circle()
                            .foregroundColor(Color("NeutralGray2"))
                            .frame(width: .infinity, height: 16)
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
