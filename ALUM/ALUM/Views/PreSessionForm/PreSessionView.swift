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
                    backDestination: LoginScreen(),
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
    
    @State var otherName: String = ""
    @State var date: String = ""
    @State var time: String = ""

    var body: some View {
        print(viewModel.isLoading)
        return
        Group {
            if !viewModel.isLoading {
                PreSessionQuestionScreen(viewModel: viewModel, notesID: notesID, otherUser: otherName, date: date, time: time)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            } else {
                Text("Loading...")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
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
        // .navigationBarBackButtonHidden()
        
    }
}

struct PreSessionView_Previews: PreviewProvider {
    static var previews: some View {
        PreSessionView()
    }
}
