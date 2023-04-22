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
    @State var currNotes: String = "this" // "this" or "other"

    func setMyNotes() {
        currNotes = "mine"
    }

    func setOtherNotes() {
        currNotes = "other"
    }
    
    var body: some View {
        VStack {
            StaticProgressBarComponent(nodes: viewModel.questionList.count, filledNodes: viewModel.questionList.count, activeNode: 0)
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
                        try await viewModel.submitNotesPatch()
                        self.viewModel.submitSuccess = true
                    } catch {
                        print("Error")
                    }
                }
            } label: {
                Text("Save")
            }
            .buttonStyle(FilledInButtonStyle())

            NavigationLink(destination: SessionConfirmationScreen(text: ["Post-session form saved!", "You can continue on the notes later under \"Sessions\".", "Great"]),
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
                    Text("MY NOTES")
                        .font(.custom("Metropolis-Regular", size: 16))
                        .foregroundColor(Color("ALUM Dark Blue"))
                }
                .padding(.trailing, 40)
                Button {
                    setOtherNotes()
                } label: {
                    Text("MENTOR NOTES")
                        .font(.custom("Metropolis-Regular", size: 16))
                        .foregroundColor(Color("ALUM Dark Blue"))
                }
                Spacer()
            }
            .padding(.leading, 16)
            Divider()
                .background(Color("ALUM Light Blue"))
                .frame(width: 358)
                .padding(.bottom, 32)

            ForEach((currNotes == "this") ? viewModel.questionList : viewModel.questionListOther, id: \.self) { currQuestion in
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
