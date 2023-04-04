//
//  SignUpConfirmationMentor.swift
//  ALUM
//
//  Created by Yash Ravipati on 3/1/23.
//

import SwiftUI
import WrappingHStack

struct SignUpConfirmationMentor: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpViewModel
    var body: some View {
        VStack {
            ProgressBarComponent(nodes: 3, filledNodes: 1, activeNode: 2)
                .background(Color.white)
            ScrollView {
                content
            }
            footer
                .padding(.horizontal, 16)
                .padding(.top, 32)
                .padding(.bottom, 40)
                .background(Rectangle().fill(Color.white).shadow(radius: 8))
        }
        .edgesIgnoringSafeArea(.bottom)
        .applySignUpScreenHeaderModifier()
    }
    
    var footer: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Label(
                    title: { Text("Edit") },
                    icon: { Image(systemName: "pencil.line") }
                )
            }
            .buttonStyle(OutlinedButtonStyle())
            
            Spacer()
            Button("Submit") {
                Task {
                    do {
                        try await viewModel.submitMentorSignUp()
                        self.viewModel.submitSuccess = true
                    } catch {
                        print("Error")
                    }
                }
            }
            .buttonStyle(FilledInButtonStyle())
            
            NavigationLink(destination: LoginPageView(), isActive: $viewModel.submitSuccess) {
                EmptyView()
            }
        }
    }
    
    var content: some View {
        VStack {
            HStack {
                Text("Confirmation")
                    .font(Font.custom("Metropolis-Regular", size: 34, relativeTo: .largeTitle))
                
                    .foregroundColor(Color("NeutralGray3"))
                    .padding(.leading)
                    .padding(.top)
                Spacer()
            }
            .padding(.bottom, 24)
            HStack {
                Text("Name: ")
                    .padding(.leading)
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                Text(viewModel.mentor.name)
                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                Spacer()
            }
            .padding(.bottom, 16)
            HStack {
                Text("Email: ")
                    .padding(.leading)
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                Text(viewModel.mentor.email)
                    .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                Spacer()
            }
            .padding(.bottom, 24)
            Group {
                HStack {
                    Text("School: ")
                        .padding(.leading, 16)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    Text(viewModel.mentor.university)
                        .padding(.leading)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            Group {
                HStack {
                    Text("Major")
                        .padding(.leading)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    Text(viewModel.mentor.major)
                        .padding(.leading)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            Group {
                HStack {
                    Text("Minor")
                        .padding(.leading)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    Text(viewModel.mentor.minor)
                        .padding(.leading)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            Group {
                HStack {
                    Text("Intended Career")
                        .padding(.leading)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    Text(viewModel.mentor.intendedCareer)
                        .padding(.leading)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            VStack {
                HStack {
                    Text("Topics of Expertise:")
                        .padding(.leading)
                        .padding(.bottom, 8)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    Spacer()
                }
                WrappingHStack(viewModel.mentor.topicsOfExpertise.sorted(), id: \.self) { topic in
                    TagDisplay(
                        tagString: topic,
                        crossShowing: true,
                        crossAction: {
                            viewModel.mentor.topicsOfExpertise.remove(topic)
                        }
                    )
                    .padding(.bottom, 8)
                }
                .padding(.trailing, 16)
                .padding(.leading, 16)
            }
            .padding(.bottom, 32)
            Group {
                HStack {
                    Text("Mentor Motivation")
                        .padding(.leading)
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .padding(.trailing, 37)
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 8)
                HStack {
                    Text(viewModel.mentor.mentorMotivation)
                        .padding(.leading)
                        .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .lineSpacing(5)
                    Spacer()
                }
                .padding(.bottom, 100)
            }
        }
    }
}

struct SignUpConfirmationMentor_Previews: PreviewProvider {
    static private var viewModel = SignUpViewModel()
    static var previews: some View {
        SignUpConfirmationMentor(viewModel: viewModel)
    }
}
