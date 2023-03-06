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
        HStack {
            ZStack {
                Circle()
                    .strokeBorder(Color("ALUM Dark Blue"), lineWidth: 2.0)
                    .frame(width: 20, height: 20)

                if isSelected {
                    Circle()
                        .fill(Color("ALUM Dark Blue"))
                        .frame(width: 4, height: 4)
                }
            }
            .padding(.leading, 24)
            .padding(.trailing, 10)
            .padding(.top, 14)
            .padding(.bottom, 14)

            Text(grade)
                .font(.custom("Metropolis-Regular", size: 17))
                .padding(.trailing, 20)
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(isSelected ? Color("ALUM Light Blue") : Color("ALUM White"))
                    .padding(.trailing, 8)
                    .padding(.leading, 8)
                    .frame(height: 48.0)

                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(Color("ALUM Light Blue"))
                    .padding(.trailing, 8)
                    .padding(.leading, 8)
                    .frame(height: 48.0)
            }
        )
    }
}

struct SignUpGradeComponent_Previews: PreviewProvider {

    static var grade: String = "9"
    static var isSelected: Bool = true

    static var previews: some View {
        SignUpGradeComponent(grade: grade, isSelected: isSelected)
    }
}
