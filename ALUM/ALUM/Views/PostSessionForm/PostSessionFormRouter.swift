//
//  PostSessionFormRouter.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/27/23.
//

import SwiftUI

struct PostSessionFormRouter: View {
    @StateObject private var viewModel = QuestionViewModel()

    var notesID: String
    var otherNotesId: String
    var otherName: String
    var date: String
    var time: String
    
    var body: some View {
        loadingAbstraction
            .customNavBarItems(
                title: "\(date) Post-session Notes", 
                isPurple: false, 
                backButtonHidden: false
            )
    }
    
    var loadingAbstraction: some View {
        return Group {
            if viewModel.isLoading {
                LoadingView(text: "PostSessionFormRouter \(notesID)")
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.fetchPostSessionNotes(
                                    notesId: notesID, 
                                    otherNotesId: otherNotesId
                                )
                            } catch {
                                print("ERROR PostSessionFormRouter \(error)")
                            }
                        }
                    }
            } else {
                loadedView
            }
        }
    }
    
    var loadedView: some View {
        print(viewModel.questionList)
        return VStack {
            DynamicProgressBarComponent(nodes: $viewModel.questionList.count + 1,
                                        filledNodes: $viewModel.currentIndex, activeNode: $viewModel.currentIndex)
                .padding()
                .background(Color.white)
            if viewModel.currentIndex < viewModel.questionList.count {
                PostSessionQuestionScreen(viewModel: viewModel, otherUser: otherName, date: date, time: time, noteId: notesID)
            } else {
                PostSessionConfirmationScreen(viewModel: viewModel, notesID: notesID)
            }
        }
    }
}

struct PostSessionFormRouter_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            PostSessionFormRouter(
                notesID: "646c8ea5004999f332c55f84", 
                otherNotesId: "646c8ea5004999f332c55f86",
                otherName: "Mentor", 
                date: "5/23", 
                time: "9pm"
            )
        }
    }
}

