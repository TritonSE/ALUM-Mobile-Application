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
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            StaticProgressBarComponent(nodes: viewModel.questionList.count,
                                       filledNodes: viewModel.questionList.count, activeNode: 0)
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
                        try await viewModel.submitNotesPatch(noteID: "6450d7933551f6470d1f5c9b")
                        self.viewModel.submitSuccess = true
                    } catch {
                        print("Error")
                    }
                }
            } label: {
                Text("Save")
            }
            .buttonStyle(FilledInButtonStyle())
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
        PreSessionConfirmationScreen(viewModel: viewModel)
    }
}
