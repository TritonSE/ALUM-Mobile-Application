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
            PreSessionConfirmationScreen(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden()
    }
}

struct PreSessionView_Previews: PreviewProvider {
    static var previews: some View {
        PreSessionView()
    }
}
