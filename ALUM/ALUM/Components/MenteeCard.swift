//
//  MenteeCard.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/8/23.
//

import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path =
        UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct MenteeCard: View {
    @State var name = "Timby Wolf"
    @State var profilePic = Image("TestMenteePFP")
    @State var isEmpty = false
    var body: some View {
        Button {
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .frame(width: 110, height: 135)
                    .offset(y: 32)
                    .foregroundColor(Color("ALUM Dark Blue"))
                if isEmpty {
                    Rectangle()                .frame(width: 110, height: 75)
                        .cornerRadius(12.0, corners: .topLeft)
                        .cornerRadius(12.0, corners: .topRight)
                        .foregroundColor(Color("NeutralGray1"))
                } else {
                    profilePic
                        .resizable()
                        .frame(width: 110, height: 75)
                        .cornerRadius(12.0, corners: .topLeft)
                        .cornerRadius(12.0, corners: .topRight)
                }
                Text(name)
                    .font(.custom("Metropolis-Regular", size: 13, relativeTo: .footnote))
                    .foregroundColor(.white)
                    .offset(y: 65)
                    .offset(x: -8)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                    .frame(width: 75, height: 40, alignment: .leading)
            }
        }
    }
}

struct MenteeCard_Previews: PreviewProvider {
    static var previews: some View {
        MenteeCard()
    }
}
