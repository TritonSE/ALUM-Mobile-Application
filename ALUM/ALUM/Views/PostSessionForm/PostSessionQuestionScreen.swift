//
//  MenteePostSessionQuestionScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 4/5/23.
//

import SwiftUI

struct PostSessionQuestionScreen: View {

    @ObservedObject var viewModel: QuestionViewModel
    @Environment(\.dismiss) var dismiss
    @State var otherUser: String
    @State var date: String
    @State var time: String

    var body: some View {
        VStack {
            ScrollView {
                content
            }

            footer

        }
        .edgesIgnoringSafeArea(.bottom)
    }

    
    var content: some View {
        var currentIndex = viewModel.currentIndex
        if viewModel.currentIndex >= viewModel.questionList.count {
            currentIndex = viewModel.questionList.count - 1
        }
        let currentQuestion = viewModel.questionList[currentIndex]
        
        return VStack {
            if currentIndex == 0 {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("ALUM Light Blue"))
                    VStack {
                        Text("Let's reflect on your session with \(otherUser) on \(date) at \(time).")
                            .font(.custom("Metropolis-Regular", size: 17))
                            .lineSpacing(10)
                            .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                        Spacer()
                        NavigationLink(destination: MissedSessionScreen(
                            viewModel: viewModel, notesID: notesID), label: {
                                    HStack {
                                        Text("Session didn't happen?")
                                            .foregroundColor(Color("ALUM Dark Blue"))
                                            .underline()
                                            .padding(.init(top: 0, leading: 16, bottom: 8, trailing: 16))
                                        Spacer()
                                    }
                                })
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 32)
                .padding(.top, 8)
            }

            if currentQuestion.type == "text" {
                ParagraphInput(question: currentQuestion.question,
                               text: $viewModel.questionList[currentIndex].answerParagraph)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.top, 8)
            } else if currentQuestion.type == "bullet" {
                Text(viewModel.questionList[viewModel.currentIndex].question)
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .font(Font.custom("Metropolis-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
                    .padding(.top, 8)
                BulletsView(bullets: $viewModel.questionList[currentIndex].answerBullet,
                            question: currentQuestion.question)
            } else if currentQuestion.type == "checkbox-bullet" {
                Text(currentQuestion.question)
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .font(Font.custom("Metropolis-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
                    .padding(.top, 8)
                CheckboxBulletsView(
                    checkboxBullets:
                        $viewModel.questionList[currentIndex].answerCheckboxBullet,
                    question: currentQuestion.question)
            }
        }
    }
}

// Footer Code goes here
extension PostSessionQuestionScreen {
    @ViewBuilder
    var footer: some View {
        Group {
            if viewModel.currentIndex == 0 {
                footerForFirstQuestion
            } else {
                footerWithBackAndContinue
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 32)
        .padding(.bottom, 40)
        .background(Rectangle().fill(Color.white).shadow(radius: 8))
    }
    
    var footerForFirstQuestion: some View {
        Button {
            viewModel.nextQuestion()
        } label: {
            HStack {
                ALUMText(text: "Continue", textColor: ALUMColor.white)
                Image(systemName: "arrow.right")
                    .font(.system(size: 17))
                    .foregroundColor(Color.white)
            }
        }
        .buttonStyle(FilledInButtonStyle())
    }
    
    var footerWithBackAndContinue: some View {
        HStack {
            Button {
                viewModel.prevQuestion()
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                }
            }
            .buttonStyle(OutlinedButtonStyle())

            Spacer()

            Button {
                viewModel.nextQuestion()
            } label: {
                HStack {
                    ALUMText(text: "Continue", textColor: ALUMColor.white)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 17))
                        .foregroundColor(Color.white)
                }
            }
            .buttonStyle(FilledInButtonStyle())
        }
    }
}
//
//struct PostSessionQuestionScreen_Previews: PreviewProvider {
//    static private var viewModel = QuestionViewModel()
//
//    static var previews: some View {
//        PostSessionQuestionScreen(viewModel: viewModel)
//    }
//}
