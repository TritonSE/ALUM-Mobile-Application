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
                    backDestination: MentorSessionDetailsPage(),
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
                PostSessionQuestionScreen(viewModel: viewModel, notesID: notesID, otherUser: otherName, date: date, time: time)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            } else {
                Text("Loading...")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.loadPostNotes(notesID: notesID, otherNotesID: otherNotesID)
                            } catch {
                                print("Error")
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
