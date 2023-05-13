//
//  ViewPreSessionNotesPage.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/27/23.
//

import SwiftUI

struct ViewPreSessionNotesModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                NavigationHeaderComponent(
                    backText: "",
                    backDestination: LoginScreen(),
                    title: "Pre-session Notes",
                    purple: false
                )
            }
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyViewPreSessionNotesModifier() -> some View {
        self.modifier(ViewPreSessionNotesModifier())
    }
}

struct ViewPreSessionNotesPage: View {
    @StateObject var viewModel = QuestionViewModel()

    @State var notesID: String = ""

    var body: some View {
        Group {
            if !viewModel.isLoading {
                VStack {
                    ScrollView {
                        content
                    }
                    
                    if (viewModel.currentUser.role == UserRole.mentee) {
                        footer
                            .padding(.horizontal, 16)
                            .padding(.top, 32)
                            .padding(.bottom, 40)
                            .background(Rectangle().fill(Color.white).shadow(radius: 8))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .applyViewPreSessionNotesModifier()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.loadNotes(notesID: notesID)
                } catch {
                    print("Error")
                }
            }
        }
    }

    var footer: some View {
        NavigationLink {
            PreSessionQuestionScreen(viewModel: viewModel)
        } label: {
            HStack {
                Image(systemName: "pencil.line")
                Text("Edit")
            }
        }
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

struct ViewPreSessionNotesPage_Previews: PreviewProvider {

    static var previews: some View {
        ViewPreSessionNotesPage()
    }
}
