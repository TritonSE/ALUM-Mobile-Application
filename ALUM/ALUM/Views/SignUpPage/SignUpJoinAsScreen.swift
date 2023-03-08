//
//  SignUpJoinAsScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpJoinAsScreen: View {

    enum JoinType {
        case mentee
        case mentor
    }

    @ObservedObject var viewModel: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectedType: JoinType?

    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)

            VStack {
                ProgressBarComponent(nodes: 3, filledNodes: 1, activeNode: 2)
                    .frame(alignment: .top)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.ignoresSafeArea(edges: .top))
                    .frame(maxWidth: .infinity)

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
                                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do " +
                                         "eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                       isSelected: selectedType == .mentee)
                            .onTapGesture {
                                selectedType = .mentee
                                viewModel.isMentee = true
                                viewModel.isMentor = false
                            }
                            .padding(.bottom, 32)

                        SignUpJoinOption(title: "Mentor",
                                       description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do " +
                                         "eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                       isSelected: selectedType == .mentor)
                            .onTapGesture {
                                selectedType = .mentor
                                viewModel.isMentee = false
                                viewModel.isMentor = true
                            }
                            .padding(.bottom, 137)

                    }
                }

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                    }
                    .buttonStyle(OutlinedButtonStyle(disabled: false))
                    .padding(.bottom, 32)
                    .padding(.trailing, 16)

                    if selectedType == .mentee {
                        NavigationLink(destination: SignUpMenteeInfoScreen(viewModel: viewModel)) {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.right")
                            }

                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
                        .padding(.bottom, 32)
                    } else if selectedType == .mentor {
                        NavigationLink(destination: SignUpMentorInfoScreen(viewModel: viewModel)) {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.right")
                            }
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
                        .padding(.bottom, 32)
                    } else {
                        Button {
                            
                        } label: {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.right")
                            }
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: true))
                        .padding(.bottom, 32)
                        
                    }

                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .edgesIgnoringSafeArea(.bottom)
            }
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

struct SignUpJoinAsScreen_Previews: PreviewProvider {

    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpJoinAsScreen(viewModel: viewModel)
    }
}
