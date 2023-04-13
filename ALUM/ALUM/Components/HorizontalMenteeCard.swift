//
//  HorizontalMenteeCard.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import SwiftUI

struct HorizontalMenteeCard: View {
    @State var name: String = "Mentee Name"
    @State var grade: Int = 9
    @State var school: String = "NHS"
    @State var profilePic: Image = Image("TestMenteePFP")
    @State var isEmpty = true

    var body: some View {
        Button {
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .frame(width: 358, height: 118)
                    .foregroundColor(Color("ALUM Dark Blue"))
                if isEmpty {
                    Circle()
                        .frame(width: 85)
                        .foregroundColor(Color("NeutralGray1"))
                        .offset(x: -112.5)
                } else {
                    profilePic
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 85, height: 85)
                        .offset(x: -112.5)
                }
                VStack {
                    HStack {
                        Text(name)
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    .offset(x: 149)
                    HStack {
                        Image(systemName: "graduationcap")
                            .resizable()
                            .frame(width: 19, height: 18)
                            .foregroundColor(.white)
                        Text(String(grade) + "th Grade" + " @ " + school)
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(.white)
                            .frame(width: 200, alignment: .leading)
                        Spacer()
                    }
                    .offset(x: 150)
                    .padding(.bottom, 4)
                }
            }
        }
    }
}

struct HorizontalMenteeCard_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalMenteeCard()
    }
}
