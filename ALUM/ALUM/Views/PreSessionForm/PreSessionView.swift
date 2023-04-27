//
//  PreSessionView.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import SwiftUI

struct PreSessionScreenHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                NavigationHeaderComponent(
                    backText: "XXX",
                    backDestination: LoginPageView(),
                    title: "Pre-session Notes",
                    purple: false
                )
            }
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyPreSessionScreenHeaderModifier() -> some View {
        self.modifier(PreSessionScreenHeaderModifier())
    }
}

struct PreSessionView: View {

    @StateObject private var viewModel = QuestionViewModel()

    @State var notesID: String = ""
    
    var body: some View {
        Group {
            if !viewModel.isLoading {
                PreSessionQuestionScreen(viewModel: viewModel)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            } else {
                Text("Loading...")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
        // .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                do {
                    try await viewModel.loadNotes(notesID: notesID)
                } catch {
                    print("Error")
                }
            }
            // viewModel.loadTestData()
        }
    }
}

struct PreSessionView_Previews: PreviewProvider {
    static var previews: some View {
        PreSessionView()
    }
}
