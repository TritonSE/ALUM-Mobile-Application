//
//  MentorCard.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import SwiftUI

struct MentorCard: View {
    @State var name = "MMM Monkey"
    @State var major = "CS"
    @State var university = "UCSD"
    @State var career = "Software Engineer"
    @State var profilePic = Image("TestMenteePFP")
    @State var isEmpty = false
    var body: some View {
        Button {
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .frame(width: 358, height: 118)
                    .foregroundColor(Color("ALUM Primary Purple"))
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
                        Text("Mentor Name")
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
                        Text(major + " @ " + university)
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(.white)
                            .frame(width: 200, alignment: .leading)
                        Spacer()
                    }
                    .offset(x: 150)
                    .padding(.bottom, 4)
                    HStack {
                        Image(systemName: "suitcase")
                            .resizable()
                            .frame(width: 19, height: 15)
                        Text(career)
                        Spacer()
                    }
                    .offset(x: 150)
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct MentorCard_Previews: PreviewProvider {
    static var previews: some View {
        MentorCard()
    }
}
