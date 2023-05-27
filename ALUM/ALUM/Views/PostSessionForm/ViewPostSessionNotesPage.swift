//
//  ViewPostSessionNotesPage.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/27/23.
//

import SwiftUI

struct ViewPostSessionNotesPage: View {
    @StateObject var viewModel = QuestionViewModel()

    var notesID: String
    var otherNotesID: String
    var otherName: String
    var date: String
    var time: String
    
    @State var currNotes: String = "this" // "this" or "other"


    func setMyNotes() {
        currNotes = "this"
    }

    func setOtherNotes() {
        currNotes = "other"
    }

    var body: some View {
        loadingAbstraction
            .customNavBarItems(title: "\(date) Post-session Notes", isPurple: false, backButtonHidden: false)
    }
    var loadingAbstraction: some View {
        Group {
            if !viewModel.isLoading {
                loadedView
            } else {
                LoadingView(text: "ViewPostSessionNotesPage")
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchPostSessionNotes(
                        notesId: notesID, 
                        otherNotesId: otherNotesID
                    ) 
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
            if currNotes == "this" {
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
        return CustomNavLink (
            destination: 
                PostSessionFormRouter(
                    notesID: notesID, 
                    otherNotesId: otherNotesID,
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
        ViewPostSessionNotesPage(notesID: "646c8ea5004999f332c55f84", otherNotesID: "646c8ea5004999f332c55f86", otherName: "Mentor", date: "5/23", time: "9:30 AM")
    }
}
