//
//  ProgressBarComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/25/23.
//

import SwiftUI

struct DynamicProgressBarComponent: View {
    @State var nodes: Int
    @Binding var filledNodes: Int
    @Binding var activeNode: Int

    var body: some View {
        GeometryReader { (geometry) in
            self.makeView(geometry)
        }.fixedSize(horizontal: false, vertical: true)
    }

    func makeView(_ geometry: GeometryProxy) -> some View {
        return ZStack {
            HStack(spacing: 0) {
                ForEach(0 ..< nodes - 1, id: \.self) { index in
                    if index < activeNode || index < filledNodes {
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
                        if index == activeNode {
                            ActiveCircle()
                        } else if index < filledNodes + 1 {
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
