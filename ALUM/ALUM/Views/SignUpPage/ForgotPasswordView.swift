//
//  ForgotPasswordView.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 5/9/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        NavigationView {
             ForgotPasswordSetUpScreen(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
