//
//  PostSessionConfirmationScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 4/11/23.
//

import SwiftUI

struct PostSessionConfirmationScreen: View {
    @ObservedObject var viewModel: QuestionViewModel
    @Environment(\.dismiss) var dismiss
    @State var notesID: String = ""
    @State var currNotes: String = "this" // "this" or "other"

    func setMyNotes() {
        currNotes = "this"
    }

    func setOtherNotes() {
        currNotes = "other"
    }

    var body: some View {
        VStack {
            StaticProgressBarComponent(nodes: viewModel.questionList.count,
                                       filledNodes: viewModel.questionList.count, activeNode: 0)
                .background(Color.white)

            ScrollView {
                content
            }
            footer
                .padding(.horizontal, 16)
                .padding(.top, 32)
                .padding(.bottom, 40)
                .background(Rectangle().fill(Color.white).shadow(radius: 8))
        }
        .edgesIgnoringSafeArea(.bottom)
        .applyPostSessionScreenHeaderModifier()
    }

    var footer: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                }
            }
            .buttonStyle(OutlinedButtonStyle())

            Spacer()

            Button {
                Task {
                    do {
                        // (todo) remove hardcoding
                        try await viewModel.submitNotesPatch(noteID: notesID)
                        self.viewModel.submitSuccess = true
                    } catch {
                        print("Error")
                    }
                }
            } label: {
                Text("Save")
            }
            .buttonStyle(FilledInButtonStyle())
            NavigationLink(destination: SessionConfirmationScreen(
                text: ["Post-session form saved!",
                       "You can continue on the notes later under \"Sessions\".", "Great"]),
                           isActive: $viewModel.submitSuccess) {
                EmptyView()
            }
        }
    }

    var content: some View {
        VStack {
            HStack {
                Text("Summary")
                    .font(.custom("Metropolis-Regular", size: 34))
                    .foregroundColor(Color("NeutralGray3"))
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 32)
            .padding(.top, 8)

            HStack {
                Button {
                    setMyNotes()
                } label: {
                    if currNotes == "this" {
                        Text("MY NOTES")
                            .font(.custom("Metropolis-Regular", size: 16))
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .bold()
                    } else {
                        Text("MY NOTES")
                            .font(.custom("Metropolis-Regular", size: 16))
                            .foregroundColor(Color("ALUM Dark Blue"))
                    }

                }
                .padding(.trailing, 40)
                Button {
                    setOtherNotes()
                } label: {
                    if currNotes == "other" {
                        Text((viewModel.currentUser.role == UserRole.mentee) ? "MENTOR NOTES" : "MENTEE NOTES")
                            .font(.custom("Metropolis-Regular", size: 16))
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .bold()
                    } else {
                        Text((viewModel.currentUser.role == UserRole.mentee) ? "MENTOR NOTES" : "MENTEE NOTES")
                            .font(.custom("Metropolis-Regular", size: 16))
                            .foregroundColor(Color("ALUM Dark Blue"))
                    }
                }
                Spacer()
            }
            .padding(.leading, 16)
            ZStack {
                Divider()
                    .background(Color("ALUM Light Blue"))
                    .frame(width: 358)
                    .padding(.bottom, 32)
                if currNotes == "this" {
                    Divider()
                        .background(Color("ALUM Dark Blue").frame(height: 3))
                        .frame(width: 84)
                        .padding(.bottom, 32)
                        .padding(.trailing, 275)
                } else {
                    Divider()
                        .background(Color("ALUM Dark Blue").frame(height: 3))
                        .frame(width: 129)
                        .padding(.bottom, 32)
                        .padding(.leading, 35)
                }
            }

            ForEach((currNotes == "this") ? viewModel.questionList : viewModel.questionListOther,
                    id: \.self) { currQuestion in
                HStack {
                    Text(currQuestion.question)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))

                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 8)

                if currQuestion.type == "text" {
                    HStack {
                        Text(currQuestion.answerParagraph)
                            .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))

                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 32)
                } else if currQuestion.type == "bullet" {
                    VStack {
                        ForEach(currQuestion.answerBullet, id: \.self) { item in
                            HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 5.0))
                                Text(item)
                                    .font(Font.custom("Metropolis-Regular",
                                                      size: 17,
                                                      relativeTo: .headline))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 2)
                                    .lineSpacing(4.0)
                                Spacer()
                            }
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                        }
                    }
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

struct PostSessionConfirmationScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        PostSessionConfirmationScreen(viewModel: viewModel)
    }
}
