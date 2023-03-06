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

        VStack {
            HStack {
                Text(title)
                    .font(.custom("Metropolis-Regular", size: 34))
                Spacer()

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

            }
            .padding(.leading, 32)
            .padding(.trailing, 32)
            .padding(.bottom, 8)
            .padding(.top, 16)

            Text(description)
                .font(.custom("Metropolis-Regular", size: 17))
                .lineSpacing(4.0)
                .padding(.leading, 32)
                .padding(.trailing, 32)
                .padding(.bottom, 16)
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(isSelected ? Color("ALUM Light Blue") : Color.white)
                    .padding(.trailing, 16)
                    .padding(.leading, 16)

                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(Color("ALUM Light Blue"))
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
            }
        )
    }
}

 struct SignUpJoinOption_Previews: PreviewProvider {
     static var title: String = "Mentee"
     static var description: String = "abcdefhijklmnopqrstuvwxyz"
     static var isSelected: Bool = true

     static var previews: some View {
         SignUpJoinOption(title: title, description: description, isSelected: isSelected)
     }
 }
