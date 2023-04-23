//
//  SignUpGradeComponent.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpGradeComponent: View {

    var grade: String
    var isSelected: Bool

    var body: some View {
        let fillColor = isSelected ? ALUMColor.extraLightPurple : ALUMColor.white
        let borderColor = isSelected ? ALUMColor.primaryPurple : ALUMColor.lightPurple
        let textColor = ALUMColor.black
        let circleColor = ALUMColor.primaryPurple

        return HStack {
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
            .padding(.top, 14)
            .padding(.bottom, 14)

            ALUMText(text: grade, textColor: textColor)
                .fixedSize()
        }
        .padding(.leading, 24)
        .padding(.trailing, 20)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(fillColor.color)
                    .padding(.trailing, 8)
                    .padding(.leading, 8)
                    .frame(height: 48.0)

                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(borderColor.color)
                    .padding(.trailing, 8)
                    .padding(.leading, 8)
                    .frame(height: 48.0)
            }
        )
    }
}

struct SignUpGradeComponent_Previews: PreviewProvider {

    static var grade: String = "10"

    static var previews: some View {
        SignUpGradeComponent(grade: grade, isSelected: true)
        SignUpGradeComponent(grade: grade, isSelected: false)

    }
}
