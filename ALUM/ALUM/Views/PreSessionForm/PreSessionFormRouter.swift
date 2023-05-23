//
//  PreSessionFormRouter.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/23/23.
//

import SwiftUI

struct PreSessionFormRouter: View {
    @StateObject private var viewModel = QuestionViewModel()

    var notesID: String
    var otherName: String
    var date: String
    var time: String
    
    var body: some View {
        loadingAbstraction
            .customNavBarItems(
                title: "\(date) Pre-session Notes", 
                isPurple: false, 
                backButtonHidden: false
            )
    }
    
    var loadingAbstraction: some View {
        print("isLoading \(viewModel.isLoading)")
        return Group {
            if viewModel.isLoading {
                LoadingView(text: "PreSessionFormRouter \(notesID)")
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.fetchNotes(noteId: notesID)
                            } catch {
                                print("ERROR PreSessionFormRouter \(error)")
                            }
                        }
                    }
            } else {
                loadedView
            }
        }
    }
    
    var loadedView: some View {
        return VStack {
            DynamicProgressBarComponent(nodes: $viewModel.questionList.count + 1,
                                        filledNodes: $viewModel.currentIndex, activeNode: $viewModel.currentIndex)
                .padding()
                .background(Color.white)
            if viewModel.currentIndex < viewModel.questionList.count {
                PreSessionQuestionScreen(viewModel: viewModel, otherUser: otherName, date: date, time: time)
            } else {
                PreSessionConfirmationScreen(viewModel: viewModel, notesID: notesID)
            }
        }
    }
}

struct PreSessionFormRouter_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            PreSessionFormRouter(notesID: "6464276b6f05d9703f069761", otherName: "Mentor", date: "5/23", time: "9pm")
        }
    }
}
