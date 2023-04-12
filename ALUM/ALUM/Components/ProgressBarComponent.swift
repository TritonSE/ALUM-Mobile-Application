//
//  ProgressBarComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/25/23.
//

import SwiftUI

let circleDiameter = CGFloat(16)
let borderWidth = CGFloat(3)

struct ProgressBarComponent: View {
    @State var nodes = 3
    @State var filledNodes = 1
    @State var activeNode = 2

    var body: some View {
        GeometryReader { (geometry) in
            self.makeView(geometry)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
    }

    func makeView(_ geometry: GeometryProxy) -> some View {
        return ZStack {
            HStack(spacing: 0) {
                ForEach(0 ..< nodes - 1, id: \.self) { index in
                    if index < activeNode-1 || index < filledNodes - 1 {
                        FilledLine()
                    } else {
                        PendingLine()
                    }
                }
            }

            HStack(spacing: 0) {
                ForEach(0 ..< nodes, id: \.self) { index in
                    Group {
                        if index > 0 {
                            Spacer()
                        }
                    }
                    Group {
                        if index == activeNode - 1 {
                            ActiveCircle()
                        } else if index < filledNodes {
                            FilledCircle()
                        } else {
                            PendingCircle()
                        }
                    }
                    Group {
                        if index < (nodes - 1) {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct ActiveCircle: View {
    var body: some View {
        Circle()
            .foregroundColor(Color("ALUM Light Blue"))
            .frame(width: circleDiameter - borderWidth, height: circleDiameter - borderWidth)
            .overlay(
                Circle()
                    .stroke(Color("ALUM Dark Blue"), lineWidth: borderWidth)
            )
            .frame(height: circleDiameter)
    }
}

struct FilledCircle: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("ALUM Dark Blue"))
                .frame(width: circleDiameter, height: circleDiameter)
            Image("CheckMarkVector")
        }
    }
}

struct PendingCircle: View {
    var body: some View {
        Circle()
            .foregroundColor(Color("NeutralGray2"))
            .frame(width: circleDiameter, height: circleDiameter)
    }
}

struct FilledLine: View {
    var body: some View {
        Rectangle()
            .frame(width: .infinity, height: 2)
            .foregroundColor(Color("ALUM Dark Blue"))
    }
}

struct PendingLine: View {
    var body: some View {
        Rectangle()
            .frame(width: .infinity, height: 2)
            .foregroundColor(Color("NeutralGray2"))
    }
}

struct ProgressBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressBarComponent()
            ProgressBarComponent(nodes: 5, filledNodes: 2, activeNode: 3)
        }
    }
}
