//
//  SessionDetailsScreen.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/22/23.
//

// swiftlint:disable file_length

import SwiftUI

let isMVP: Bool = true

struct SessionDetailsScreen: View {
    var sessionId: String

    @StateObject private var viewModel = SessionDetailViewModel()
    // Shows/Hides the calendly web view
    @State public var showCalendlyWebView = false

    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        return loadingAbstraction
            .customNavigationIsPurple(false)
    }

    var loadingAbstraction: some View {
        Group {
            if viewModel.isLoading || viewModel.session == nil {
                LoadingView(text: "SessionDetailsScreen \(sessionId)")
                    .onAppear(perform: {
                        Task {
                            do {
                                try await viewModel.fetchSession(sessionId: sessionId)
                            } catch {
                                print("Error")
                            }
                        }
                    })
            } else {
                navigationBarConfig
            }
        }
    }

    var navigationBarConfig: some View {
        let session = viewModel.session!
        var otherName: String

        switch currentUser.role {
        case .mentee:
            otherName = session.mentorName
        case .mentor:
            otherName = session.menteeName
        case .none:
            otherName = ""
            // (todo) Internal error
        }

        return ScrollView {
            screenContent
        }
        .customNavigationTitle("\(session.dateShortHandString) Session with \(otherName)")
        .background(ALUMColor.beige.color)
    }

    var screenContent: some View {
        let session = viewModel.session!

        return VStack(alignment: .leading) {
            if currentUser.role == .mentee {
                menteeView
            } else {
                mentorView
            }
            if !session.hasPassed {
                Button {

                } label: {
                    ALUMText(text: "Cancel Session", textColor: ALUMColor.red)
                }
                .buttonStyle(OutlinedButtonStyle())
                .border(ALUMColor.red.color)
                .cornerRadius(8.0)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 28)

    }

    // Section which displays the date and time
    var dateTimeDisplaySection: some View {
        let session = viewModel.session!

        return VStack(alignment: .leading) {
            HStack {
                ALUMText(text: "Date & Time", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, 5)
            HStack {
                ALUMText(text: session.fullDateString, textColor: ALUMColor.black)
                Spacer()
            }
            .padding(.bottom, 5)

            HStack {
                ALUMText(text: "\(session.startTimeString) - \(session.endTimeString)", textColor: ALUMColor.black)
                Spacer()
            }
        }
        .padding(.bottom, 20)
    }

    var bookSessionButton: some View {
        let session = viewModel.session!
        let buttonDisabled: Bool = !session.postSessionMenteeCompleted

        return Button {
            showCalendlyWebView = true
        } label: {
            ALUMText(text: "Book Session via Calendly", textColor: ALUMColor.white)
        }
        .disabled(buttonDisabled)
        .sheet(isPresented: $showCalendlyWebView) {
            CalendlyView()
        }
        .buttonStyle(FilledInButtonStyle(disabled: buttonDisabled))
        .padding(.bottom, 26)
    }

    var locationSectionForAny: some View {
        let session = viewModel.session!

        return Group {
            HStack {
                ALUMText(text: "Location", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, 5)

            HStack {
                ALUMText(text: session.location ?? "Not specified", textColor: ALUMColor.primaryBlue)
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }

    var postSessionNotesSectionForAny: some View {
        let session = viewModel.session!
        var formIsComplete: Bool, editableNoteId: String, otherNoteId: String, otherName: String

        if session.postSessionMentee == nil || session.postSessionMentor == nil {
            print("Attempting to display session view but no post session notes IDs present ")
            // (todo) internal error
        }

        switch currentUser.role {
        case .mentee:
            formIsComplete = session.postSessionMenteeCompleted
            editableNoteId = session.postSessionMentee!
            otherNoteId = session.postSessionMentor!
            otherName = session.mentorName
        case .mentor:
            formIsComplete = session.postSessionMentorCompleted
            editableNoteId = session.postSessionMentor!
            otherNoteId = session.postSessionMentee!
            otherName = session.menteeName
        case .none:
            formIsComplete = true
            editableNoteId = ""
            otherNoteId = ""
            otherName = ""
        }

        return Group {
            HStack {
                ALUMText(text: "Post-Session Form", textColor: ALUMColor.gray4)

                Spacer()
            }
            .padding(.bottom, formIsComplete ? 20 : 5)

            if !formIsComplete {
                HStack {
                    FormIncompleteComponent(type: "Post")
                    Spacer()
                }
                .padding(.bottom, 22)
            }

            if !formIsComplete {
                CustomNavLink(
                    destination: PostSessionFormRouter(
                        notesID: editableNoteId,
                        otherNotesId: otherNoteId,
                        otherName: otherName,
                        date: session.dateShortHandString,
                        time: session.startTimeString
                    ),
                    label: {
                        ALUMText(text: "Complete Post-Session Notes", textColor: ALUMColor.white)
                    }
                )
                .buttonStyle(FilledInButtonStyle())
                .padding(.bottom, 5)
            } else {
                CustomNavLink(
                    destination: ViewPostSessionNotesPage(
                        notesID: editableNoteId,
                        otherNotesID: otherNoteId,
                        otherName: otherName,
                        date: session.dateShortHandString,
                        time: session.startTimeString
                    ),
                    label: {
                        ALUMText(text: "View Post-Session Notes", textColor: ALUMColor.white)
                    }
                )
                .buttonStyle(FilledInButtonStyle())
                .padding(.bottom, 5)
            }
        }
    }

    var viewPreSessionNotesForAny: some View {
        let session = viewModel.session!
        var otherName: String
        switch currentUser.role {
        case .mentee:
            otherName = session.mentorName
        case .mentor:
            otherName = session.menteeName
        case .none:
            otherName = ""
        }
        return CustomNavLink(
            destination: ViewPreSessionNotesPage(
                allowEditing: false,
                notesID: session.preSession,
                otherName: otherName
            ),
            label: {
                ALUMText(text: "View Pre-Session Notes")
            }
        )
        .buttonStyle(OutlinedButtonStyle())
        .padding(.bottom, 5)
    }

    var afterEventSectionForAny: some View {
        let session = viewModel.session!

        return VStack {
            if session.missedSessionReason == nil {
                postSessionNotesSectionForAny
            } else {
                HStack {
                    ALUMText(
                        text: "Session was not completed due to: \(session.missedSessionReason!)",
                        textColor: ALUMColor.red
                    )
                    Spacer()
                }
                .padding(.bottom, 10)
            }
            viewPreSessionNotesForAny
        }
    }
}

// Sections only for mentor
extension SessionDetailsScreen {
    var mentorView: some View {
        let session = viewModel.session!

        return Group {
            HStack {
                ALUMText(text: "Mentee", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, 5)

            CustomNavLink(
                destination:
                    MenteeProfileScreen(
                        uID: session.menteeId
                    ).customNavigationTitle("Mentee Profile")
                ) {
                HorizontalMenteeCard(
                    menteeId: session.menteeId,
                    isEmpty: true
                )
                .padding(.bottom, 28)
            }
            dateTimeDisplaySection
            if session.hasPassed {
                afterEventSectionForAny
            } else {
                beforeEventSectionMentor
            }
        }
    }

    var beforeEventSectionMentor: some View {
        return Group {
            locationSectionForAny
            preSessionNotesSectionForMentor
        }
    }

    var preSessionNotesSectionForMentor: some View {
        // Mentor can view mentee's pre-session notes
        let session = viewModel.session!

        return Group {
            HStack {
                ALUMText(text: "Pre-Session Form", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, 20)

            CustomNavLink(
                destination: ViewPreSessionNotesPage(
                    allowEditing: false,
                    notesID: session.preSession,
                    otherName: session.menteeName
                ), label: {
                    ALUMText(text: "View Pre-Session Form", textColor: ALUMColor.white)
                })
            .buttonStyle(FilledInButtonStyle())
            .padding(.bottom, 5)
        }
    }
}

// Sections only for mentee
extension SessionDetailsScreen {
    var menteeView: some View {
        let session = viewModel.session!

        return Group {
            bookSessionButton

            HStack {
                ALUMText(text: "Mentor", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, 5)

            CustomNavLink(destination:
                MentorProfileScreen(uID: session.mentorId)
                .customNavigationTitle("Mentor Profile")
            ) {
                MentorCard(isEmpty: true, uID: session.mentorId)
                    .padding(.bottom, 28)
            }
            dateTimeDisplaySection

            if session.hasPassed {
                afterEventSectionForAny
            } else {
                beforeEventSectionMentee
            }
        }

    }

    var beforeEventSectionMentee: some View {
        return Group {
            locationSectionForAny
            Button {
                print("TODO Reschedule Session not implemented")
            } label: {
                ALUMText(text: "Reschedule Session")
            }
            .buttonStyle(OutlinedButtonStyle())
            .padding(.bottom, 20)
            preSessionNotesSectionForMentee
        }
    }

    var preSessionNotesSectionForMentee: some View {
        let session = viewModel.session!

        return Group {
            HStack {
                ALUMText(text: "Pre-Session Form", textColor: ALUMColor.gray4)
                Spacer()
            }
            .padding(.bottom, viewModel.formIsComplete ? 20 : 5)

            if !session.preSessionCompleted {
                HStack {
                    FormIncompleteComponent(type: "Pre")
                    Spacer()
                }
                .padding(.bottom, 22)
            }

            if !session.preSessionCompleted {

                CustomNavLink(
                    destination:
                        PreSessionFormRouter(
                            notesID: session.preSession,
                            otherName: session.mentorName,
                            date: session.dateShortHandString,
                            time: session.startTimeString
                        ),
                    label: {
                        ALUMText(text: "Complete Pre-Session Notes", textColor: ALUMColor.white)
                    }
                )
                .buttonStyle(FilledInButtonStyle())
                .padding(.bottom, 5)
            } else {
                CustomNavLink(
                    destination: ViewPreSessionNotesPage(
                        allowEditing: true,
                        notesID: session.preSession,
                        otherName: session.mentorName,
                        date: session.dateShortHandString,
                        time: session.startTimeString
                    ), label: {
                        ALUMText(text: "View Pre-Session Notes", textColor: ALUMColor.white)
                    })
                    .buttonStyle(FilledInButtonStyle())
                    .padding(.bottom, 5)
            }
        }
    }
}
struct SessionDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserModel.shared.setCurrentUser(
            isLoading: false,
            isLoggedIn: true,
            uid: "6431b9a2bcf4420fe9825fe5",
            role: .mentee
        )

        return CustomNavView {
            SessionDetailsScreen(sessionId: "6464276b6f05d9703f069760")
        }
    }
}

// swiftlint:enable file_length
