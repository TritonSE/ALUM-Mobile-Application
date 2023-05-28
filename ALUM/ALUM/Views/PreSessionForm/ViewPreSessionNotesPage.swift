//
//  ViewPreSessionNotesPage.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/27/23.
//

import SwiftUI

struct ViewPreSessionNotesPage: View {
    var allowEditing: Bool
    var notesID: String
    var otherName: String
    var date: String = ""
    var time: String = ""

    @StateObject var viewModel = QuestionViewModel()

    var body: some View {
        loadingAbstraction
            .customNavBarItems(title: "\(date) Pre-session Notes", isPurple: false, backButtonHidden: false)
    }

    var loadingAbstraction: some View {
        Group {
            if !viewModel.isLoading {
                loadedView
            } else {
                LoadingView(text: "ViewPreSessionNotesPage")
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchPreSessionNotes(noteId: notesID)
                } catch {
                    print("Error")
                }
            }
        }
    }

    var loadedView: some View {
        VStack {
            ScrollView {
                content
            }

            if allowEditing {
                footer
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                    .padding(.bottom, 40)
                    .background(Rectangle().fill(Color.white).shadow(radius: 8))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    var footer: some View {
        return CustomNavLink(
            destination:
                PreSessionFormRouter(
                    notesID: notesID,
                    otherName: otherName,
                    date: date,
                    time: time
                ),
            label: {
                HStack {
                   Image(systemName: "pencil.line")
                   Text("Edit")
               }
            })
            .buttonStyle(FilledInButtonStyle())
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

            ForEach(viewModel.questionList, id: \.self) { currQuestion in
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

struct ViewPreSessionNotesPage_Previews: PreviewProvider {

    static var previews: some View {
        ViewPreSessionNotesPage(allowEditing: false, notesID: "", otherName: "mentor")
    }
}
