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
                    backDestination: Text("TODO Blank"),
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
                    backDestination: LoginScreen(),
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

    @State var notesID: String = ""
    @State var otherNotesID: String = ""

    @State var otherName: String = ""
    @State var date: String = ""
    @State var time: String = ""

    var body: some View {
        Group {
            if !viewModel.isLoading {
                PostSessionQuestionScreen(
                    viewModel: viewModel,
                    otherUser: otherName,
                    date: date,
                    time: time
                )
            } else {
                Text("Loading...")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.fetchPostSessionNotes(notesId: notesID, otherNotesId: otherNotesID)
                            } catch {
                                print("Error \(error)")
                            }
                        }
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
