//
//  SignUpJoinOption.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpJoinOption: View {

    var title: String
    var description: String
    var isSelected: Bool

    var body: some View {
        let fillColor = isSelected ? ALUMColor.extraLightPurple : ALUMColor.white
        let borderColor = isSelected ? ALUMColor.primaryPurple : ALUMColor.lightPurple
        let textColor = ALUMColor.black
        let circleColor = ALUMColor.primaryPurple
        VStack(alignment: .leading) {
            HStack {
                ALUMText(text: title, fontSize: .largeFontSize, textColor: textColor)
                Spacer()

                ZStack {
                    Circle()
                        .strokeBorder(circleColor.color, lineWidth: 2.0)
                        .frame(width: 20, height: 20)

                    if isSelected {
                        Circle()
                            .fill(circleColor.color)
                            .frame(width: 4, height: 4)
                    }
                }
            }
            .padding(.leading, 32)
            .padding(.trailing, 32)
            .padding(.bottom, 8)
            .padding(.top, 16)

            ALUMText(text: description, textColor: textColor)
                .lineSpacing(4.0)
                .padding(.leading, 32)
                .padding(.trailing, 32)
                .padding(.bottom, 16)
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(fillColor.color)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .stroke(borderColor.color, lineWidth: 2)
                    )
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
            }
        )
    }
}

 struct SignUpJoinOption_Previews: PreviewProvider {
     static var title: String = "Mentee"
     static var description: String = "abcdefhijklmnopqrstuvwxyz\ngugduwydjsghsgdjg\n"
     static var isSelected: Bool = true

     static var previews: some View {
         SignUpJoinOption(title: title, description: description, isSelected: true)
         SignUpJoinOption(title: title, description: description, isSelected: false)
     }
 }
