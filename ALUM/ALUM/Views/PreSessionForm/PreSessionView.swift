//
//  PreSessionView.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import SwiftUI

struct PreSessionView: View {

    @StateObject private var viewModel = QuestionViewModel()

    var body: some View {
        NavigationView {
            if !viewModel.isLoading {
                PreSessionQuestionScreen(viewModel: viewModel)
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

struct PreSessionView_Previews: PreviewProvider {
    static var previews: some View {
        PreSessionView()
    }
}
