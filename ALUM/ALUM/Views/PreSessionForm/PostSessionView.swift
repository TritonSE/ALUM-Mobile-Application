//
//  PostSessionView.swift
//  ALUM
//
//  Created by Jenny Mar on 4/5/23.
//

import SwiftUI

struct PostSessionScreenHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                NavigationHeaderComponent(
                    backText: "XXX",
                    backDestination: LoginPageView(),
                    title: "Post-session Notes",
                    purple: false
                )
            }
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyPostSessionScreenHeaderModifier() -> some View {
        self.modifier(PostSessionScreenHeaderModifier())
    }
}

struct MissedSessionScreenHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                NavigationHeaderComponent(
                    backText: "XXX",
                    backDestination: LoginPageView(),
                    title: "Missed Session",
                    purple: false
                )
            }
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyMissedSessionScreenHeaderModifier() -> some View {
        self.modifier(MissedSessionScreenHeaderModifier())
    }
}

struct PostSessionView: View {
    @StateObject private var viewModel = QuestionViewModel()

    var body: some View {
        Group {
            if !viewModel.isLoading {
                if viewModel.currentIndex == viewModel.questionList.count {
                    PostSessionConfirmationScreen(viewModel: viewModel)
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                }
                else {
                    PostSessionQuestionScreen(viewModel: viewModel)
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                }
            } else {
                Text("Loading...")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.loadPostNotes()
                } catch {
                    print("Error")
                }
            }
        }
    }
}

struct PostSessionView_Previews: PreviewProvider {
    static var previews: some View {
        PostSessionView()
    }
}
