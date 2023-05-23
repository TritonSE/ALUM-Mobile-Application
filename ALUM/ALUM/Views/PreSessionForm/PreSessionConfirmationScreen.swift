//
//  PreSessionConfirmationScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//
// Notes:
// The button titled "XXX" currently leads back to the login page, check where it should actually be leading back to.
import SwiftUI

struct PreSessionConfirmationScreen: View {

    @ObservedObject var viewModel: QuestionViewModel
    var notesID: String

    var body: some View {
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
    }

    var footer: some View {
        HStack {
            Button {
                viewModel.prevQuestion()
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    ALUMText(text: "Back")
                }
            }
            .buttonStyle(OutlinedButtonStyle())

            Spacer()

            Button {
                Task {
                    do {
                        try await viewModel.submitNotesPatch(noteID: notesID)
                        self.viewModel.submitSuccess = true
                    } catch {
                        print("Error")
                    }
                }
            } label: {
                ALUMText(text: "Save", textColor: ALUMColor.white)
            }
            .buttonStyle(FilledInButtonStyle())
            // TODO change this to custom nav link
            NavigationLink(destination: SessionConfirmationScreen(
                text: ["Pre-session form saved!",
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

struct PreSessionConfirmationScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        PreSessionConfirmationScreen(viewModel: viewModel, notesID: "6464276b6f05d9703f069761")
    }
}
