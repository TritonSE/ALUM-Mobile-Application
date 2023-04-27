//
//  PreSessionQuestionScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 3/15/23.
//

import SwiftUI

struct PreSessionQuestionScreen: View {

    @ObservedObject var viewModel: QuestionViewModel
    @Environment(\.dismiss) var dismiss
    @State var otherUser: String = "Mentor"
    @State var date: String = "date"
    @State var time: String = "time"

    var body: some View {
        VStack {
            DynamicProgressBarComponent(nodes: $viewModel.questionList.count, filledNodes: $viewModel.currentIndex, activeNode: $viewModel.currentIndex)
                .padding()
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
        .applyPreSessionScreenHeaderModifier()
    }

    @ViewBuilder
    var footer: some View {
        if !viewModel.lastQuestion {
            if viewModel.currentIndex == 0 {
                Button {
                    viewModel.nextQuestion()
                } label: {
                    HStack {
                        Text("Continue")
                            .font(.custom("Metropolis-Regular", size: 17))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                    }
                }
                .buttonStyle(FilledInButtonStyle())
            } else {
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
                            Text("Continue")
                                .font(.custom("Metropolis-Regular", size: 17))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 17))
                                .foregroundColor(Color.white)
                        }
                    }
                    .buttonStyle(FilledInButtonStyle())
                }
            }
        } else {
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

                NavigationLink(destination: PreSessionConfirmationScreen(viewModel: viewModel), label: {
                    HStack {
                        Text("Continue")
                            .font(.custom("Metropolis-Regular", size: 17))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                    }
                })
                .buttonStyle(FilledInButtonStyle())
            }
        }
    }

    // viewModel.questionList[index].answerBullet
    var content: some View {
        VStack {
            if viewModel.currentIndex == 0 {
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

            if viewModel.questionList[viewModel.currentIndex].type == "text" {
                ParagraphInput(question: viewModel.questionList[viewModel.currentIndex].question, text: $viewModel.questionList[viewModel.currentIndex].answerParagraph)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.top, 8)
            } else if viewModel.questionList[viewModel.currentIndex].type == "bullet" {
                Text(viewModel.questionList[viewModel.currentIndex].question)
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .font(Font.custom("Metropolis-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
                    .padding(.top, 8)
                BulletsView(bullets: $viewModel.questionList[viewModel.currentIndex].answerBullet, question: viewModel.questionList[viewModel.currentIndex].question)
            }
        }
    }
}

struct PreSessionQuestionScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        PreSessionQuestionScreen(viewModel: viewModel)
    }
}
