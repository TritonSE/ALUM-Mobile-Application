//
//  PreSessionQuestionScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 3/15/23.
//

import SwiftUI

struct PreSessionQuestionScreen: View {

    @ObservedObject var viewModel: QuestionViewModel

    var otherUser: String
    var date: String
    var time: String

    var body: some View {
        VStack {
            ScrollView {
                content
            }
            footer
        }
        .dismissKeyboardOnDrag()
        .edgesIgnoringSafeArea(.bottom)
    }

    var content: some View {
        var currentIndex = viewModel.currentIndex
        if viewModel.currentIndex >= viewModel.questionList.count {
            currentIndex = viewModel.questionList.count - 1
        }
        let currentQuestion = viewModel.questionList[currentIndex]

        return VStack {
            if viewModel.currentIndex == 0 {
                firstQuestionBanner
            }

            if currentQuestion.type == "text" {
                ParagraphInput(
                    question: currentQuestion.question,
                    text: $viewModel.questionList[currentIndex].answerParagraph
                )
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 8)
            } else if currentQuestion.type == "bullet" {
                ALUMText(text: currentQuestion.question, textColor: ALUMColor.primaryBlue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.bottom, 16)
                .padding(.top, 8)

                BulletsView(bullets: $viewModel.questionList[currentIndex].answerBullet,
                            question: currentQuestion.question)
            }
        }
    }

    var firstQuestionBanner: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("ALUM Light Blue"))
            Text("You have successfully booked a session with \(otherUser) on \(date) at \(time).")
                .font(.custom("Metropolis-Regular", size: 17))
                .lineSpacing(10)
                .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 32)
        .padding(.top, 8)
    }
}

// Footer Code goes here
extension PreSessionQuestionScreen {
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
struct PreSessionQuestionScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        PreSessionQuestionScreen(viewModel: viewModel, otherUser: "Mentor", date: "5/23", time: "9pm")
    }
}
