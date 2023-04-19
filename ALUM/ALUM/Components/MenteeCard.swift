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
    @State var isEmpty = false
    @State var uID: String = ""
    @StateObject private var viewModel = MenteeProfileViewmodel()
    @State var isClicked = false
    var body: some View {
        if !isClicked {
            Button {
                isClicked = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12.0)
                        .frame(width: 110, height: 135)
                        .offset(y: 32)
                        .foregroundColor(Color("ALUM Primary Purple"))
                    if isEmpty {
                        Rectangle()                .frame(width: 110, height: 75)
                            .cornerRadius(12.0, corners: .topLeft)
                            .cornerRadius(12.0, corners: .topRight)
                            .foregroundColor(Color("NeutralGray1"))
                    } else {
                        Image(viewModel.menteeGET.mentee.imageId)
                            .resizable()
                            .frame(width: 110, height: 75)
                            .cornerRadius(12.0, corners: .topLeft)
                            .cornerRadius(12.0, corners: .topRight)
                    }
                    Text(viewModel.menteeGET.mentee.name)
                        .font(.custom("Metropolis-Regular", size: 13, relativeTo: .footnote))
                        .foregroundColor(.white)
                        .offset(y: 65)
                        .offset(x: -8)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(5)
                        .frame(width: 75, height: 40, alignment: .leading)
                }
            }
            .onAppear(perform: {
                Task {
                    do {
                        try await viewModel.getMenteeInfo(userID: uID)
                    } catch {
                        print("Error")
                    }
                }
            })
        } else {
            MenteeProfileView(uID: viewModel.menteeGET.mentee.id)
        }
    }
}

struct MenteeCard_Previews: PreviewProvider {
    static var previews: some View {
        MenteeCard(isEmpty: true)
    }
}
