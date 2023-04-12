//
//  PostSessionConfirmationScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 4/11/23.
//

import SwiftUI

struct PostSessionConfirmationScreen: View {
    @ObservedObject var viewModel: QuestionViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PostSessionConfirmationScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        PostSessionConfirmationScreen(viewModel: viewModel)
    }
}
