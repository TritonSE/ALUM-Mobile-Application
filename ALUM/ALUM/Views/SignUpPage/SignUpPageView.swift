//
//  SignUpPageView.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/17/23.
//

import SwiftUI

struct SignUpPageView: View {

    @StateObject private var viewModel = SignUpPageViewModel()

    var body: some View {
        NavigationView {
            SignUpSetUp(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden()
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView()
        // MentorInfo()
    }
}

