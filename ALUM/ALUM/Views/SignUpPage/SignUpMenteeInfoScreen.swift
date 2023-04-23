//
//  SignUpMenteeInfoScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI
import WrappingHStack

struct SignUpMenteeInfoScreen: View {

    enum GradeType {
        case nine
        case ten
        case eleven
        case twelve
    }

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpViewModel

    @State var interestsIsShowing: Bool = false
    @State var careerIsShowing: Bool = false
    @State var goalIsShowing: Bool = false
    @State var selectedGrade: GradeType?
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

            NavigationLink(destination: SignUpConfirmationMentee(viewModel: viewModel), label: {
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
        VStack {
            HStack {
                ALUMText(text: "Tell us about yourself", fontSize: .largeFontSize)
                    .foregroundColor(Color("NeutralGray3"))
                Spacer()
            }
            .padding(.bottom, 32)
            .padding(.leading, 16)
            .padding(.top, 8)

            HStack {
                ALUMText(text: "Grade")
                    .foregroundColor(Color("ALUM Dark Blue"))
                Spacer()
            }
            .padding(.bottom, 2)
            .padding(.leading, 16)

            HStack {
                SignUpGradeComponent(grade: "9", isSelected: selectedGrade == .nine)
                    .onTapGesture {selectedGrade = .nine; viewModel.mentee.grade = 9}
                SignUpGradeComponent(grade: "10", isSelected: selectedGrade == .ten)
                    .onTapGesture {selectedGrade = .ten; viewModel.mentee.grade = 10}
                SignUpGradeComponent(grade: "11", isSelected: selectedGrade == .eleven)
                    .onTapGesture {selectedGrade = .eleven; viewModel.mentee.grade = 11}
                SignUpGradeComponent(grade: "12", isSelected: selectedGrade == .twelve)
                    .onTapGesture {selectedGrade = .twelve; viewModel.mentee.grade = 12}
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 32)

            HStack {
                ALUMText(text: "Topics of Interest")
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.bottom, 2)

            Button {
                interestsIsShowing = true
            }  label: {
                if viewModel.mentee.topicsOfInterest.isEmpty {
                    HStack {
                        ALUMText(text: "Search to add topics")
                            .foregroundColor(Color("NeutralGray3")).padding(.leading, 16)

                        Spacer()
                    }
                    .frame(height: 48.0)
                    .background(Color("ALUM White").cornerRadius(8.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
                    )
                    .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                } else {
                    VStack {
                        WrappingHStack(viewModel.mentee.topicsOfInterest.sorted(), id: \.self) { interest in
                            TagDisplay(
                                tagString: interest,
                                crossShowing: true,
                                crossAction: {
                                    viewModel.mentee.topicsOfInterest.remove(interest)
                                }
                            )
                            .padding(.bottom, 16)
                        }

                        HStack {
                            AddTagButton(text: "Add Topic", isShowing: $interestsIsShowing)
                                .padding(.bottom, 16)

                            Spacer()
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 32)
                    .padding(.top, 14)
                }
            }
            .sheet(isPresented: $interestsIsShowing, onDismiss: {
                interestsIsShowing = false
            }, content: {
                TagEditor(selectedTags: $viewModel.mentee.topicsOfInterest,
                          tempTags: viewModel.mentee.topicsOfInterest,
                          screenTitle: "Topics of Interest",
                          predefinedTags: TopicsOfInterest.topicsOfInterest)
                .padding(.top, 22)
            })

            HStack {
                ALUMText(text: "Career Interests")
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.bottom, 2)

            Button {
                careerIsShowing = true
            }  label: {
                if viewModel.mentee.careerInterests.isEmpty {
                    HStack {
                        ALUMText(text: "Search to add interests")
                            .foregroundColor(Color("NeutralGray3"))
                            .padding(.leading, 16)

                        Spacer()
                    }
                    .frame(height: 48.0)
                    .background(
                        Color("ALUM White")
                            .cornerRadius(8.0)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color("NeutralGray3"), lineWidth: 1.0)
                    )
                    .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                } else {
                    VStack {
                        WrappingHStack(viewModel.mentee.careerInterests.sorted(), id: \.self) { interest in
                            TagDisplay(
                                tagString: interest,
                                crossShowing: true,
                                crossAction: {
                                    viewModel.mentee.careerInterests.remove(interest)
                                }
                            )
                            .padding(.bottom, 16)
                        }

                        HStack {
                            AddTagButton(text: "Add Career", isShowing: $careerIsShowing)
                                .padding(.bottom, 16)

                            Spacer()
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 32)
                    .padding(.top, 14)
                }
            }
            .sheet(isPresented: $careerIsShowing,
                   content: {
                TagEditor(selectedTags: $viewModel.mentee.careerInterests,
                          tempTags: viewModel.mentee.careerInterests,
                          screenTitle: "Career Interests",
                          predefinedTags: CareerInterests.menteeCareerInterests)
                .padding(.top, 22)
            }
            )

            HStack {
                ALUMText(text: "What do you hope to get out of \nmentorship?")
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.bottom, 2)

            MentorshipGoal(goalIsShowing: $goalIsShowing,
                           mentorshipGoal: $viewModel.mentee.mentorshipGoal,
                           tempGoal: viewModel.mentee.mentorshipGoal)
        }
        .onAppear {
            viewModel.setUpMentee()
            if viewModel.mentee.grade == 9 {
                selectedGrade = .nine
            } else if viewModel.mentee.grade == 10 {
                selectedGrade = .ten
            } else if viewModel.mentee.grade == 11 {
                selectedGrade = .eleven
            } else if viewModel.mentee.grade == 12 {
                selectedGrade = .twelve
            }
        }
    }
}

struct MentorshipGoal: View {
    @Binding var goalIsShowing: Bool
    @Binding var mentorshipGoal: String
    @State var tempGoal: String = ""

    func cancel() {
        tempGoal = mentorshipGoal
        goalIsShowing = false
    }

    func done(textfield: String) {
        mentorshipGoal = tempGoal
        goalIsShowing = false
    }

    var body: some View {
        Button {
            goalIsShowing = true
        } label: {
            ResizingTextBox(text: $tempGoal)
        }
        .sheet(isPresented: $goalIsShowing,
               content: {
            DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                ParagraphInput(question: "What do you hope to get out of mentorship?", text: $tempGoal)
            }
        }
        )
    }
}

struct SignUpMenteeInfoScreen_Previews: PreviewProvider {

    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpMenteeInfoScreen(viewModel: viewModel)
    }
}
