//
//  SignUpMentorInfoScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI
import WrappingHStack

struct SignUpMentorInfoScreen: View {
    @ObservedObject var viewModel: SignUpViewModel
    @Environment(\.dismiss) var dismiss

    @State var yearIsShowing: Bool = false
    @State var universityIsShowing: Bool = false
    @State var whyMentorIsShowing: Bool = false
    @State var expertiseIsShowing: Bool = false

    var body: some View {
        VStack {
            ProgressBarComponent(nodes: 3, filledNodes: 2, activeNode: 3)
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
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                }
            }
            .buttonStyle(OutlinedButtonStyle(disabled: false))
            .padding(.trailing, 16)
            .frame(width: UIScreen.main.bounds.width * 0.3)

            NavigationLink(destination: SignUpConfirmationMentor(viewModel: viewModel), label: {
                HStack {
                    Text("Continue")
                    Image(systemName: "arrow.right")
                }
            })
            .buttonStyle(FilledInButtonStyle(disabled: false))
            .frame(width: UIScreen.main.bounds.width * 0.6)
        }
    }

    var content: some View {
        VStack(alignment: .leading) {
            ALUMText(text: "Tell us about yourself", fontSize: .largeFontSize, textColor: ALUMColor.gray3)
            .padding(.bottom, 32).padding(.leading, 16).padding(.top, 8)

            ALUMText(text: "Year of Graduation from Northwood")
            .padding(.bottom, 2).padding(.leading, 16)

            Button {
                yearIsShowing = true
            } label: {
                ZStack(alignment: .trailing) {
                    HStack {

                        if viewModel.mentor.yearOfGrad != 0 {
                            ALUMText(text: String(viewModel.mentor.yearOfGrad), textColor: ALUMColor.black)
                        } else {
                            ALUMText(text: "Select a year", textColor: ALUMColor.gray3)
                        }
                        Spacer()
                    }
                    .padding(.leading, 16)

                    Image(systemName: "chevron.down").padding(.trailing, 16)
                }

            }
            .sheet(isPresented: $yearIsShowing,
                   content: {
                SelectYearComponent(year: $viewModel.mentor.yearOfGrad,
                                    yearChoice: viewModel.mentor.yearOfGrad)
            })
            .frame(height: 48.0)
            .background(ALUMColor.white.color.cornerRadius(8.0))
            .overlay(
                RoundedRectangle(cornerRadius: 8.0).stroke(ALUMColor.gray3.color, lineWidth: 1.0)
            )
            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))

            ALUMText(text: "College/University")
            .padding(.bottom, 2).padding(.leading, 16)

            Button {
                universityIsShowing = true
            } label: {
                HStack {
                    if viewModel.mentor.university != "" {
                        Text(viewModel.mentor.university).foregroundColor(.black)
                    } else {
                        ALUMText(text: "Search for your school", textColor: ALUMColor.gray3)
                    }
                    Spacer()
                }
                .padding(.leading, 16)
            }
            .sheet(isPresented: $universityIsShowing, content: {
                SelectUniversityComponent(universityChoice: viewModel.mentor.university,
                                          university: $viewModel.mentor.university)
            })
            .frame(height: 48.0)
            .background(ALUMColor.white.color.cornerRadius(8.0))
            .overlay(
                RoundedRectangle(cornerRadius: 8.0).stroke(ALUMColor.gray3.color, lineWidth: 1.0)
            )
            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))

            ALUMTextFieldComponent(title: "Major",
                                   suggestion: "e.g. Economics, Statistics",
                                   text: $viewModel.mentor.major)

            ALUMTextFieldComponent(title: "Minor",
                                   suggestion: "e.g. Literature, Psychology",
                                   text: $viewModel.mentor.minor)

            ALUMTextFieldComponent(title: "Intended Career",
                                   suggestion: "e.g. Software Engineer, Product Designer",
                                   text: $viewModel.mentor.intendedCareer)

            Group {
                ALUMText(text: "Topics of Expertise")
                .padding(.leading, 16)
                .padding(.bottom, 2)

                Button {
                    expertiseIsShowing = true
                }  label: {
                    if viewModel.mentor.topicsOfExpertise.isEmpty {
                        HStack {
                            ALUMText(text: "Search to add topics", textColor: ALUMColor.gray3)
                                .padding(.leading, 16)

                            Spacer()
                        }
                        .frame(height: 48.0)
                        .background(ALUMColor.white.color.cornerRadius(8.0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(ALUMColor.gray3.color, lineWidth: 1.0)
                        )
                        .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                    } else {
                        VStack {
                            WrappingHStack(viewModel.mentor.topicsOfExpertise.sorted(),
                                           id: \.self) { topic in
                                TagDisplay(
                                    tagString: topic,
                                    crossShowing: true,
                                    crossAction: {
                                        viewModel.mentor.topicsOfExpertise.remove(topic)
                                    }
                                )
                                .padding(.bottom, 16)
                            }

                            HStack {
                                AddTagButton(text: "Add Topic", isShowing: $expertiseIsShowing)
                                    .padding(.bottom, 16)

                                Spacer()
                            }
                        }
                        .padding(.leading, 16).padding(.trailing, 16)
                        .padding(.bottom, 32).padding(.top, 14)
                    }
                }
                .sheet(isPresented: $expertiseIsShowing,
                       content: {
                    TagEditor(selectedTags: $viewModel.mentor.topicsOfExpertise,
                              tempTags: viewModel.mentor.topicsOfExpertise,
                              screenTitle: "Topics of Expertise",
                              predefinedTags: TopicsOfInterest.topicsOfInterest)
                    .padding(.top, 22)
                }
                )
            }

            Group {
                HStack {
                    ALUMText(text: "Why do you want to be a mentor?")
                    Spacer()
                }
                .padding(.leading, 16).padding(.bottom, 2)

                WhyMentor(whyMentorIsShowing: $whyMentorIsShowing,
                          whyMentor: $viewModel.mentor.mentorMotivation,
                          tempGoal: viewModel.mentor.mentorMotivation)
            }
        }

        .onAppear {
            viewModel.setUpMentor()
        }
    }
}

struct WhyMentor: View {
    @Binding var whyMentorIsShowing: Bool
    @Binding var whyMentor: String
    @State var tempGoal: String = ""

    func cancel() {
        tempGoal = whyMentor
        whyMentorIsShowing = false
    }

    func done(textfield: String) {
        whyMentor = tempGoal
        whyMentorIsShowing = false
    }

    var body: some View {
        Button {
            whyMentorIsShowing = true
        } label: {
            ResizingTextBox(text: $tempGoal)
        }
        .sheet(isPresented: $whyMentorIsShowing,
               content: {
            DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                ParagraphInput(question: "Why do you want to be a mentor?", text: $tempGoal)
            }
        }
        )
    }
}

struct SignUpMentorInfoScreen_Previews: PreviewProvider {
    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpMentorInfoScreen(viewModel: viewModel)
    }
}
