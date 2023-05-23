//
//  PreSessionView.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import SwiftUI

struct PreSessionView: View {

    @StateObject private var viewModel = QuestionViewModel()

    @State var notesID: String = ""

    @State var otherName: String = ""
    @State var date: String = ""
    @State var time: String = ""

    var body: some View {
        content
            .customNavBarItems(
                title: "\(date) Pre-session Notes", 
                isPurple: false, 
                backButtonHidden: false
            )
    }
    var content: some View {
        return
        Group {
            if !viewModel.isLoading {
                PreSessionQuestionScreen(
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
                                try await viewModel.fetchNotes(noteId: notesID)
                            } catch {
                                print("Error")
                            }
                        }
                        // viewModel.loadTestData()
                    }
            }
        }
        // .navigationBarBackButtonHidden()

    }
}

struct PreSessionView_Previews: PreviewProvider {
    static var previews: some View {
        PreSessionView()
    }
}
