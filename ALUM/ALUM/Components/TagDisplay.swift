//
//  TagDisplay.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 2/20/23.
//

import SwiftUI

struct TagDisplay: View {
    var tagString: String = ""
    let crossShowing: Bool
    let crossAction: (() -> Void)?

    init(tagString: String, crossShowing: Bool = false, crossAction: (() -> Void)? = nil) {
        self.tagString = tagString
        self.crossShowing = crossShowing
        self.crossAction = crossAction
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                        .frame(width: 12)

                    ALUMText(text: tagString, textColor: ALUMColor.black)
                    Spacer()
                        .frame(width: 12)

                    if crossShowing {
                        Button(action: {
                            crossAction?()
                        }, label: {
                            Image(systemName: "xmark")
                        })
                        .foregroundColor(ALUMColor.white.color)
                        .frame(height: 8)
                        .frame(width: 8)
                        Spacer()
                            .frame(width: 16)
                    }

                }

            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 100).stroke())
            .foregroundColor(ALUMColor.lightPurple.color)
            .background(ALUMColor.lightPurple.color)
            .cornerRadius(100)
            .frame(height: 40)

        }
    }
}

struct TagDisplay_Previews: PreviewProvider {
    static var previews: some View {
        TagDisplay(tagString: "Sample New Text @12345")
        TagDisplay(tagString: "Sample New Text @12345", crossShowing: true)
    }
}
