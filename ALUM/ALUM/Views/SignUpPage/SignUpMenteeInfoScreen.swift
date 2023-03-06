//
//  SignUpMenteeInfoScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpMenteeInfoScreen: View {

    enum GradeType {
        case nine
        case ten
        case eleven
        case twelve
    }

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpViewModel
    @State var selectedGrade: GradeType?

    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)

            VStack {

                ProgressBarComponent(nodes: 3, filledNodes: 2, activeNode: 3)
                    .frame(alignment: .top)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.ignoresSafeArea(edges: .top))
                    .frame(maxWidth: .infinity)

                ScrollView {
                    VStack {
                        HStack {
                            Text("Tell us about yourself")
                                .font(.custom("Metropolis-Regular", size: 34))
                                .foregroundColor(Color("NeutralGray3"))
                            Spacer()
                        }
                        .padding(.bottom, 32)
                        .padding(.leading, 16)
                        .padding(.top, 8)

                        HStack {
                            Text("Grade")
                                .font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(Color("ALUM Dark Blue"))

                            Spacer()
                        }
                        .padding(.bottom, 2)
                        .padding(.leading, 16)

                        HStack {
                            SignUpGradeComponent(grade: "9", isSelected: selectedGrade == .nine)
                                .onTapGesture {
                                    selectedGrade = .nine
                                    viewModel.mentee.grade = "9"
                                }
                            SignUpGradeComponent(grade: "10", isSelected: selectedGrade == .ten)
                                .onTapGesture {
                                    selectedGrade = .ten
                                    viewModel.mentee.grade = "10"
                                }
                            SignUpGradeComponent(grade: "11", isSelected: selectedGrade == .eleven)
                                .onTapGesture {
                                    selectedGrade = .eleven
                                    viewModel.mentee.grade = "11"
                                }
                            SignUpGradeComponent(grade: "12", isSelected: selectedGrade == .twelve)
                                .onTapGesture {
                                    selectedGrade = .twelve
                                    viewModel.mentee.grade = "12"
                                }
                        }
                        .padding(.bottom, 32)

                        HStack {
                            Text("What do you hope to get out of \nmentorship?")
                                .lineSpacing(4.0)
                                .font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(Color("ALUM Dark Blue"))

                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 2)

                        ZStack {
                            TextField("", text: $viewModel.mentee.mentorshipGoal)
                                .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                                .frame(height: 48.0)
                                .background(
                                    Color("ALUM White")
                                        .cornerRadius(8.0)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
                                )
                        }
                        .padding(.init(top: 0.0, leading: 16.0, bottom: 67.0, trailing: 16.0))
                    }
                }

                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 114)
                        .foregroundColor(Color.white)
                        .ignoresSafeArea(edges: .all)

                    HStack {
                        Button("Back") {
                            dismiss()
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
                        .padding(.trailing, 16)
                        .padding(.bottom, 32)
                        .frame(width: UIScreen.main.bounds.width * 0.3)

                        Button("Continue") {

                        }
                        .buttonStyle(OutlinedButtonStyle(disabled: false))
                        .padding(.bottom, 32)
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
                .frame(alignment: .bottom)
                .frame(maxWidth: .infinity)
                .background(Color.white.ignoresSafeArea(edges: .bottom))
                .frame(maxWidth: .infinity)
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
            viewModel.setUpMentee()
            if viewModel.mentee.grade == "9" {
                selectedGrade = .nine
            } else if viewModel.mentee.grade == "10" {
                selectedGrade = .ten
            } else if viewModel.mentee.grade == "11" {
                selectedGrade = .eleven
            } else if viewModel.mentee.grade == "12" {
                selectedGrade = .twelve
            }
        }
    }
}

struct SignUpMenteeInfoScreen_Previews: PreviewProvider {

    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpMenteeInfoScreen(viewModel: viewModel)
    }
}
