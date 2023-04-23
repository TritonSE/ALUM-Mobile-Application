//
//  SignUpPageView.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/17/23.
//

import SwiftUI

struct SignUpScreenHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                NavigationHeaderComponent(
                    backText: "Login",
                    backDestination: LoginPageView(),
                    title: "Signup"
                )
            }
            content
                .background(ALUMColor.beige.color)
        }
    }
}

extension View {
    func applySignUpScreenHeaderModifier() -> some View {
        self.modifier(SignUpScreenHeaderModifier())
    }
}

struct SignUpPageView: View {
    @StateObject private var viewModel = SignUpViewModel()

    var body: some View {
        NavigationView {
             SignUpSetUpScreen(viewModel: viewModel)
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
