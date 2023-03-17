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

    
    // viewModel.questionList[index].answerBullet
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("ALUM White 2").edgesIgnoringSafeArea(.all)
                VStack {
                    DynamicProgressBarComponent(nodes: $viewModel.questionList.count, filledNodes: $viewModel.currentIndex, activeNode: $viewModel.currentIndex)
                        .frame(alignment: .top)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                    ScrollView {
                        VStack {
                            if viewModel.currentIndex == 0 {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color("ALUM Light Blue"))
                                    Text("You have successfully booked a session with [Mentor Name] on [date] at [time]!")
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
                                ParagraphInput(question: $viewModel.questionList[viewModel.currentIndex].question, text: $viewModel.questionList[viewModel.currentIndex].answerParagraph)
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
                                BulletsView(bullets: $viewModel.questionList[viewModel.currentIndex].answerBullet, question: $viewModel.questionList[viewModel.currentIndex].question)
                            }
                        }
                    }
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 114)
                            .foregroundColor(Color.white)
                            .ignoresSafeArea(edges: .all)
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
                                .buttonStyle(FilledInButtonStyle(disabled: false))
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
                                    .buttonStyle(OutlinedButtonStyle(disabled: false))
                                    .padding(.trailing, 16)
                                    .padding(.bottom, 32)

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
                                    .buttonStyle(FilledInButtonStyle(disabled: false))
                                    .padding(.bottom, 32)
                                    .frame(width: geometry.size.width * 0.575)
                                }
                            }
                        }
                        else {
                            HStack {
                                Button {
                                    viewModel.prevQuestion()
                                } label: {
                                    HStack {
                                        Image(systemName: "arrow.left")
                                        Text("Back")
                                    }
                                }
                                .buttonStyle(OutlinedButtonStyle(disabled: false))
                                .padding(.trailing, 16)
                                .padding(.bottom, 32)
                                
                                NavigationLink(destination: PreSessionConfirmationScreen(viewModel: viewModel), label: {
                                    HStack {
                                        Text("Continue")
                                            .font(.custom("Metropolis-Regular", size: 17))
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 17))
                                            .foregroundColor(Color.white)
                                    }
                                })
                                .buttonStyle(FilledInButtonStyle(disabled: false))
                                .padding(.bottom, 32)
                                .frame(width: geometry.size.width * 0.575)
                            }
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .frame(alignment: .bottom)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.ignoresSafeArea(edges: .bottom))
                        
                }
            }
            .navigationBarItems(leading: NavigationLink(
                destination: LoginPageView(),
                label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("XXX")
                            .font(.custom("Metropolis-Regular", size: 13))
                    }
                }
            ))
            .navigationBarTitle(Text("Pre-Session Notes").font(.custom("Metropolis-Regular", size: 17)),
                                displayMode: .inline)
            .navigationBarBackButtonHidden()
        }
    }
}

struct PreSessionQuestionScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        PreSessionQuestionScreen(viewModel: viewModel)
    }
}
