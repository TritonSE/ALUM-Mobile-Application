//
//  MissedSessionScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 4/5/23.
//

import SwiftUI

struct MissedSessionScreen: View {
    enum OptionType {
        case cancelled
        case emergency
        case forgot
        case notShowed
        case other
        case notSay
    }

    @ObservedObject var viewModel: QuestionViewModel
    var notesID: String
    var date: String
    var time: String
    var otherUser: String

    @Environment(\.dismiss) var dismiss
    @State var validated: Bool = true
    @State var selectedOption: OptionType?
    @State var noOption: Bool = false
    @State var otherEmpty: Bool = false
    @State var otherText: String = ""

    var body: some View {
        VStack {
            KeyboardAwareView {
                ScrollView {
                    content
                }
            }
            footer
                .padding(.horizontal, 16)
                .padding(.top, 32)
                .padding(.bottom, 34)
        }
        .dismissKeyboardOnDrag()
        .onAppear {
            if viewModel.missedOption == "Mentor/ee and I decided to cancel" {
                selectedOption = .cancelled
            } else if viewModel.missedOption == "I had an emergency" {
                selectedOption = .emergency
            } else if viewModel.missedOption == "I forgot about the session" {
                selectedOption = .forgot
            } else if viewModel.missedOption == "Other" {
                selectedOption = .other
            } else if viewModel.missedOption == "Prefer not to say" {
                selectedOption = .notSay
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    var footer: some View {
        HStack {
            Button {
                if viewModel.missedOption != "" || otherText != "" {
                    if otherText != "" {
                        selectedOption = .other
                        viewModel.missedOption = otherText
                    }
                    Task {
                        do {
                            try await viewModel.submitMissedNotesPatch(noteID: notesID)
                            self.viewModel.submitSuccess = true
                        } catch {
                            print("Error")
                        }
                    }
                } else {
                    if selectedOption == .other {
                        otherEmpty = true
                    } else {
                        noOption = true
                    }
                }
            } label: {
                Text("Submit")
            }
            .buttonStyle(FilledInButtonStyle())
            NavigationLink(destination: ConfirmationScreen(
                text: ["Missed session form submitted!",
                       "Thank you for your feedback!", "Close"]),
                           isActive: $viewModel.submitSuccess) {
                EmptyView()
            }
        }

    }

    var content: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("ALUM Light Blue"))
                ALUMText(text: "It seems that your session with \(otherUser) on \(date) at \(time) didn’t happen.")
                    .lineSpacing(10)
                    .padding(.init(top: 16, leading: 16, bottom: 8, trailing: 16))
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 32)
            .padding(.top, 8)

            HStack {
                Text("What went wrong?")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .padding(.init(top: 0, leading: 16, bottom: 3, trailing: 16))
                Spacer()
            }
            if noOption == true {
                HStack {
                    Text("Please select an option")
                        .font(.custom("Metropolis-Regular", size: 13))
                        .foregroundColor(Color("FunctionalError"))
                        .padding(.init(top: 0, leading: 16, bottom: 8, trailing: 16))
                    Spacer()
                }
            } else if otherEmpty == true {
                HStack {
                    Text("Please fill in Other")
                        .font(.custom("Metropolis-Regular", size: 13))
                        .foregroundColor(Color("FunctionalError"))
                        .padding(.init(top: 0, leading: 16, bottom: 8, trailing: 16))
                    Spacer()
                }
            }

            MultipleChoice(content: "Mentor/ee and I decided to cancel",
                           checked: selectedOption == .cancelled, otherText: $otherText)
                .onTapGesture {selectedOption = .cancelled
                    viewModel.missedOption = "Mentor/ee and I decided to cancel"
                    noOption = false; otherEmpty = false}
                .padding(.bottom, 12)
            MultipleChoice(content: "I had an emergency",
                           checked: selectedOption == .emergency,
                           otherText: $otherText)
                .onTapGesture {selectedOption = .emergency
                    viewModel.missedOption = "I had an emergency"
                    noOption = false; otherEmpty = false}
                .padding(.bottom, 12)
            MultipleChoice(content: "I forgot about the session",
                           checked: selectedOption == .forgot, otherText: $otherText)
                .onTapGesture {selectedOption = .forgot
                    viewModel.missedOption = "I forgot about the session"
                    noOption = false; otherEmpty = false}
                .padding(.bottom, 12)
            MultipleChoice(content: "Mentor/ee didn't show",
                           checked: selectedOption == .notShowed, otherText: $otherText)
                .onTapGesture {selectedOption = .notShowed
                    viewModel.missedOption = "Mentor/ee didn't show"
                    noOption = false; otherEmpty = false}
                .padding(.bottom, 6)
            MultipleChoice(content: "Other:",
                           checked: selectedOption == .other, otherText: $otherText)
                .onTapGesture {selectedOption = .other
                    viewModel.missedOption = otherText
                    noOption = false}
                .padding(.bottom, 12)
            MultipleChoice(content: "Prefer not to say",
                           checked: selectedOption == .notSay, otherText: $otherText)
                .onTapGesture {selectedOption = .notSay
                    viewModel.missedOption = "Prefer not to say"
                    noOption = false; otherEmpty = false}
                .padding(.bottom, 12)

        }
    }

    }

struct MissedSessionScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        MissedSessionScreen(
            viewModel: viewModel,
            notesID: "646a6e164082520f4fcf2f92",
            date: "9/23",
            time: "10:00 AM",
            otherUser: "Mentor"
        )
    }
}
