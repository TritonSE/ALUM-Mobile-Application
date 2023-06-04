//
//  SessionButtonComponent.swift
//  ALUM
//
//  Created by Neelam Gurnani on 5/8/23.
//

import SwiftUI

struct SessionButtonComponent: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared
    @StateObject private var viewModel = SessionDetailViewModel()
    @State var sessionId: String = ""

    var body: some View {
        Group {
            if viewModel.isLoading {
                Text("")
            } else {
                content
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchSession(sessionId: sessionId)
                } catch {
                    print(error)
                }
            }
        }
    }

    var content: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(Color("ALUM Light Purple"))
                .frame(width: 358, height: 118)
                .foregroundColor(Color.white)

            HStack {
                VStack {
                    Text(viewModel.session?.fullDateString.components(separatedBy: ",")[1] ?? "Jan")
                        .font(.custom("Metropolis-Regular", size: 13, relativeTo: .headline))
                        .foregroundColor(Color("TextGray"))
                        .padding(.bottom, 2)
                    Text(viewModel.session?.fullDateString.components(separatedBy: ",")[2] ?? "23")
                        .font(.custom("Metropolis-Regular", size: 34, relativeTo: .headline))
                        .foregroundColor(.black)
                }
                .padding(.leading, 18)

                Spacer()

                VStack {
                    HStack {
                        if currentUser.role == .mentee {
                            Text("Session with " + (viewModel.session?.mentorName ?? "Mentor"))
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                .foregroundColor(.black)
                                .padding(.bottom, 4)
                        } else {
                            Text("Session with " + (viewModel.session?.menteeName ?? "Mentee"))
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                .foregroundColor(.black)
                                .padding(.bottom, 4)
                        }

                        Spacer()
                    }
                    // "Monday, 9:00 - 10:00 AM PT"
                    HStack {
                        // swiftlint:disable:next line_length
                        Text("\(viewModel.session?.fullDateString.components(separatedBy: ",")[0] ?? "Monday"), \(viewModel.session?.startTimeString ?? "9:00") - \(viewModel.session?.endTimeString ?? "10:00 AM")")
                        .font(.custom("Metropolis-Regular", size: 11, relativeTo: .headline))
                        .foregroundColor(Color("TextGray"))
                        .padding(.bottom, 4)

                        Spacer()
                    }
                    if !viewModel.formIsComplete && !(currentUser.role == .mentor && !viewModel.sessionCompleted) {
                        HStack {
                            FormIncompleteComponent(type: viewModel.sessionCompleted ? "Post" : "Pre")
                        }
                    }
                }
                .padding(.leading, 25)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(Color("NeutralGray3"))
                    .padding(.trailing, 22)
            }
        }
    }
}

struct SessionButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        SessionButtonComponent()
    }
}
