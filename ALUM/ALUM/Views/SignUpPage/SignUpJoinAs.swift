//
//  SignUpJoinAs.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpJoinAs: View {

    enum JoinType {
        case mentee
        case mentor
    }
    
    @ObservedObject var viewModel: SignUpPageViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectedType: JoinType? = nil
    
    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)
                .overlay(alignment: .top) {
                    ProgressBarComponent(nodes: 3, filledNodes: 1, activeNode: 2)
                        .frame(alignment: .top)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                }
            ScrollView {
                VStack {
                    HStack {
                        Text("I want to join as a...")
                            .font(.custom("Metropolis-Regular", size: 34))
                            .foregroundColor(Color("NeutralGray3"))
                            .frame(width: 306, height: 41)
                            .padding(.top, 8)
                        Spacer()
                    }
                    .padding(.bottom, 32)

                    SignUpJoinOption(title: "Mentee",
                                   description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                   isSelected: selectedType == .mentee)
                        .onTapGesture {
                            selectedType = .mentee
                            viewModel.isMentee = true
                            viewModel.isMentor = false
                        }
                        .padding(.bottom, 32)
                    
                    SignUpJoinOption(title: "Mentor",
                                   description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                   isSelected: selectedType == .mentor)
                        .onTapGesture {
                            selectedType = .mentor
                            viewModel.isMentee = false
                            viewModel.isMentor = true
                        }
                        .padding(.bottom, 137)

                    HStack {
                        Button("Back") {
                            dismiss()
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
                        .padding(.bottom, 32)

                        if selectedType == .mentee {
                            NavigationLink(destination: SignUpMenteeInfo(viewModel: viewModel)) {
                                HStack {
                                    Text("Continue")
                                    Image(systemName: "chevron.right")
                                }
                                
                            }
                            .buttonStyle(OutlinedButtonStyle(disabled: false))
                            .padding(.bottom, 32)
                        } else if selectedType == .mentor {
                            NavigationLink(destination: SignUpMentorInfo(viewModel: viewModel)) {
                                HStack {
                                    Text("Continue")
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .buttonStyle(OutlinedButtonStyle(disabled: false))
                            .padding(.bottom, 32)
                        }
                        
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 62)
        }
        .navigationBarItems(leading: NavigationLink(
            destination: LoginPageView(),
                label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Login")
                            .font(.custom("Metropolis-Regular", size: 13))
                    }
                }
            )
        )
        .navigationBarTitle(Text("Sign-Up").font(.custom("Metropolis-Regular", size: 17)), displayMode: .inline)
        .navigationBarBackButtonHidden()
        .onAppear {
            if viewModel.isMentee {
                selectedType = .mentee
            } else if viewModel.isMentor {
                selectedType = .mentor
            }
        }
    }
}

/*
struct SignUpJoinAs_Previews: PreviewProvider {
    static var previews: some View {
        SignUpJoinAs()
    }
}
*/
