//
//  ViewPostSessionNotesPage.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/27/23.
//

import SwiftUI

struct ViewPostSessionNotesModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                NavigationHeaderComponent(
                    backText: "",
                    backDestination: LoginScreen(),
                    title: "Post-session Notes",
                    purple: false
                )
            }
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyViewPostSessionNotesModifier() -> some View {
        self.modifier(ViewPostSessionNotesModifier())
    }
}

struct ViewPostSessionNotesPage: View {
    @StateObject var viewModel = QuestionViewModel()
    @State var currNotes: String = "this" // "this" or "other"

    @State var notesID: String = ""
    @State var otherNotesID: String = ""

    @State var otherName: String = ""
    @State var date: String = ""
    @State var time: String = ""

    func setMyNotes() {
        currNotes = "this"
    }

    func setOtherNotes() {
        currNotes = "other"
    }

    var body: some View {
        Group {
            if !viewModel.isLoading {
                VStack {
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
                .applyViewPostSessionNotesModifier()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.loadPostNotes(notesID: notesID, otherNotesID: otherNotesID)
                } catch {
                    print("Error")
                }
            }
        }
    }

    var footer: some View {
        HStack {
            NavigationLink {
                PostSessionQuestionScreen(
                    viewModel: viewModel,
                    notesID: notesID,
                    otherUser: otherName,
                    date: date, time: time
                )
            } label: {
                HStack {
                    Image(systemName: "pencil.line")
                    Text("Edit")
                }
            }
            .buttonStyle(FilledInButtonStyle())
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

struct ViewPostSessionNotesPage_Previews: PreviewProvider {
    static var previews: some View {
        ViewPostSessionNotesPage()
    }
}
