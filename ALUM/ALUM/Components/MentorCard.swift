//
//  MentorCard.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/9/23.
//

import SwiftUI

struct MentorCard: View {
    @State var isEmpty = false
    @State var uID: String = ""
    @StateObject private var viewModel = MentorProfileViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading() {
                LoadingView(text: "MentorCard")
            } else {
                content
            }
        }.onAppear(perform: {
            Task {
                do {
                    try await viewModel.fetchMentorInfo(userID: uID)
                } catch {
                    print("Error")
                }
            }
        })
    }

    var content: some View {
        let mentor = viewModel.mentor!
        return ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .frame(width: 358, height: 118)
                .foregroundColor(Color("ALUM Primary Purple"))
            if isEmpty {
                Circle()
                    .frame(width: 85, height: 85)
                    .foregroundColor(Color("NeutralGray1"))
                    .offset(x: -112.5)
            } else {
                Image("ALUMLogoBlue")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 85, height: 85)
                    .offset(x: -112.5)
            }
            VStack {
                HStack {
                    Text(mentor.name)
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
                    Text(mentor.major + " @ " + mentor.college)
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(.white)
                        .frame(width: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .offset(x: 150)
                .padding(.bottom, 4)
                HStack {
                    Image(systemName: "suitcase")
                        .resizable()
                        .frame(width: 19, height: 15)
                    Text(mentor.career)
                    Spacer()
                }
                .offset(x: 150)
                .foregroundColor(.white)
            }
        }
    }
}

struct MentorCard_Previews: PreviewProvider {
    static var previews: some View {
        MentorCard(isEmpty: true)
    }
}
