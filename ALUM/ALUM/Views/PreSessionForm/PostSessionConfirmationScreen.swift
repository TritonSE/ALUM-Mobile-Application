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
    @State var currNotes: String = "mine" // "mine" or "mentor"

    func setMyNotes() {
        currNotes = "mine"
    }

    func setMentorNotes() {
        currNotes = "mentor"
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("ALUM White 2").edgesIgnoringSafeArea(.all)

                VStack {
                    StaticProgressBarComponent(nodes: viewModel.questionList.count,
                                               filledNodes: viewModel.questionList.count, activeNode: 0)
                        .frame(alignment: .top)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)

                    ScrollView {
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
                                    setMentorNotes()
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

                            if currNotes == "mine" {
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
                                    } else if currQuestion.type == "checkbox-bullet" {
                                        VStack {
                                            ForEach(currQuestion.answerCheckboxBullet, id: \.self) { item in
                                                HStack {
                                                    Image(systemName: "circle.fill")
                                                        .foregroundColor(Color.black)
                                                        .font(.system(size: 5.0))
                                                    Text(item.content)
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

                    ZStack {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 114)
                            .foregroundColor(Color.white)
                            .ignoresSafeArea(edges: .all)

                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.left")
                                    Text("Back")
                                }
                            }
                            .buttonStyle(OutlinedButtonStyle(disabled: false))
                            .padding(.trailing, 16)
                            .padding(.bottom, 32)
                            .frame(width: geometry.size.width * 0.3025)
                            NavigationLink(destination: SessionConfirmationScreen(text: ["Post-session form saved!", "You can continue on the notes later under \"Sessions\".", "Great"]), label: {
                                HStack {
                                    Text("Save")
                                        .font(.custom("Metropolis-Regular", size: 17))
                                }
                            })
                            .buttonStyle(FilledInButtonStyle(disabled: false))
                            .padding(.bottom, 32)
                            .frame(width: geometry.size.width * 0.575)

                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    }
                    .frame(alignment: .bottom)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.ignoresSafeArea(edges: .bottom))
                    .frame(maxWidth: .infinity)
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
                    }))
            .navigationBarTitle(Text("Post-Session Notes").font(.custom("Metropolis-Regular", size: 17)),
                                displayMode: .inline)
            .navigationBarBackButtonHidden()
        }
    }
}

struct PostSessionConfirmationScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        PostSessionConfirmationScreen(viewModel: viewModel)
    }
}
