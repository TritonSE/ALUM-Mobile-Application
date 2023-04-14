//
//  PostSessionView.swift
//  ALUM
//
//  Created by Jenny Mar on 4/5/23.
//

import SwiftUI

struct PostSessionView: View {
    @StateObject private var viewModel = QuestionViewModel()

    var body: some View {
        NavigationView {
            if !viewModel.isLoading {
                PostSessionQuestionScreen(viewModel: viewModel)
            } else {
                Text("Loading...")
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.loadTestData()
        }
    }
}

struct PostSessionView_Previews: PreviewProvider {
    static var previews: some View {
        PostSessionView()
    }
}
