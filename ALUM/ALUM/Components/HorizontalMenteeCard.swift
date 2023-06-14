//
//  HorizontalMenteeCard.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import SwiftUI

struct HorizontalMenteeCard: View {
    var menteeId: String

    var school: String = "NHS"
    @StateObject private var viewModel = MenteeProfileViewmodel()

    var body: some View {
        loadingAbstraction
    }

    var loadingAbstraction: some View {
        Group {
            if viewModel.isLoading() || viewModel.mentee == nil {
                LoadingView(text: "HorizontalMenteeCard")
            } else {
                loadedView
            }
        }.onAppear(perform: {
            Task {
                do {
                    try await viewModel.fetchMenteeInfo(userID: menteeId)
                } catch {
                    print("Error")
                }
            }
        })
    }

    var loadedView: some View {
        let mentee = viewModel.mentee!

        return ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .frame(width: 358, height: 118)
                .foregroundColor(Color("ALUM Primary Purple"))
            ProfileImage(imageId: mentee.imageId, size: 85)
                .offset(x: -112.5)
            VStack {
                HStack {
                    Text(mentee.name)
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
                    Text(String(mentee.grade) + "th Grade" + " @ " + school)
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

struct HorizontalMenteeCard_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            print("print")
        }, label: {
            HorizontalMenteeCard(menteeId: "6431b99ebcf4420fe9825fe3")
        })
    }
}
