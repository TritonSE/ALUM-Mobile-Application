//
//  HomeScreen.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/22/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared
    @State public var showCalendlyWebView = false

    var body: some View {
        loadedView
            .background(ALUMColor.beige.color)
            .customNavigationIsPurple(false)
            .customNavigationBarBackButtonHidden(true)
    }

    var loadedView: some View {
        return VStack {
            if currentUser.role == .mentee {
                menteeView
                    .customNavigationTitle("Book session with mentor")
            } else if currentUser.role == .mentor {
                mentorView
                    .customNavigationTitle("No Upcoming Session")
            }
            Button {
                FirebaseAuthenticationService.shared.logout()
            } label: {
                ALUMText(text: "Log out", textColor: ALUMColor.red)
            }
            .buttonStyle(OutlinedButtonStyle())
            .border(ALUMColor.red.color)
            .cornerRadius(8.0)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 28)
    }
    var bookSessionButton: some View {
        return Button {
            showCalendlyWebView = true
        } label: {
            ALUMText(text: "Book Session via Calendly", textColor: ALUMColor.white)
        }
        .sheet(isPresented: $showCalendlyWebView) {
            CalendlyView()
        }
        .buttonStyle(FilledInButtonStyle())
        .padding(.bottom, 26)
    }

    var mentorView: some View {
        let pairedMenteeId = currentUser.pairedMenteeId!

        return Group {
            HStack {
                ALUMText(text: "Mentee", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, 5)

            NavigationLink(destination: MenteeProfileScreen(uID: pairedMenteeId)) {
                HorizontalMenteeCard(
                    menteeId: pairedMenteeId,
                    isEmpty: true
                )
                .padding(.bottom, 28)
            }
        }
    }

    var menteeView: some View {
        print("\(currentUser.uid) \(currentUser.isLoading) \(currentUser.pairedMenteeId) \(currentUser.pairedMentorId)")
        let pairedMentorId = currentUser.pairedMentorId!

        return Group {
            bookSessionButton

            HStack {
                ALUMText(text: "Mentor", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, 5)

            NavigationLink(destination: MentorProfileScreen(uID: pairedMentorId)) {
                MentorCard(isEmpty: true, uID: pairedMentorId)
                    .padding(.bottom, 28)
            }
        }

    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserModel.shared.setCurrentUser(
            isLoading: false,
            isLoggedIn: true,
            uid: "6431b99ebcf4420fe9825fe3",
            role: .mentee
        )

        CurrentUserModel.shared.status = "paired"
        CurrentUserModel.shared.sessionId = "646a6e164082520f4fcf2f8f"
        CurrentUserModel.shared.pairedMentorId = "6431b9a2bcf4420fe9825fe5"
        return HomeScreen()
    }
}
