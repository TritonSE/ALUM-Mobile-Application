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
        VStack {
            HStack {
                Text("Tell us about yourself").font(.custom("Metropolis-Regular", size: 34))
                    .foregroundColor(Color("NeutralGray3"))
                Spacer()
            }
            .padding(.bottom, 32).padding(.leading, 16).padding(.top, 8)

            HStack {
                Text("Year of Graduation from Northwood")
                    .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.bottom, 2).padding(.leading, 16)

            Button {
                yearIsShowing = true
            } label: {
                ZStack(alignment: .trailing) {
                    HStack {

                        if viewModel.mentor.yearOfGrad != 0 {
                            Text(String(viewModel.mentor.yearOfGrad)).foregroundColor(.black)
                        } else {
                            Text("Select a year").foregroundColor(Color("NeutralGray3"))
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
            .background(Color("ALUM White").cornerRadius(8.0))
            .overlay(
                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
            )
            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))

            HStack {
                Text("College/University")
                    .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.bottom, 2).padding(.leading, 16)

            Button {
                universityIsShowing = true
            } label: {
                HStack {
                    if viewModel.mentor.university != "" {
                        Text(viewModel.mentor.university).foregroundColor(.black)
                    } else {
                        Text("Search for your school").foregroundColor(Color("NeutralGray3"))
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
            .background(Color("ALUM White").cornerRadius(8.0))
            .overlay(
                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
            )
            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
            
            Group {
                ALUMTextFieldComponent(title: "Major",
                                       suggestion: "e.g. Economics, Statistics",
                                       text: $viewModel.mentor.major)

                ALUMTextFieldComponent(title: "Minor",
                                       suggestion: "e.g. Literature, Psychology",
                                       text: $viewModel.mentor.minor)

                ALUMTextFieldComponent(title: "Intended Career",
                                       suggestion: "e.g. Software Engineer, Product Designer",
                                       text: $viewModel.mentor.intendedCareer)
                
                ALUMTextFieldComponent(title: "Location",
                                       suggestion: "e.g. Meeting ID",
                                       text: $viewModel.mentor.location)
            }

            Group {
                HStack {
                    Text("Topics of Expertise")
                        .lineSpacing(4.0)
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Dark Blue"))

                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.bottom, 2)

                Button {
                    expertiseIsShowing = true
                }  label: {
                    if viewModel.mentor.topicsOfExpertise.isEmpty {
                        HStack {
                            Text("Search to add topics").font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(Color("NeutralGray3")).padding(.leading, 16)

                            Spacer()
                        }
                        .frame(height: 48.0)
                        .background(Color("ALUM White").cornerRadius(8.0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(Color("NeutralGray3"), lineWidth: 1.0)
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
                    Text("Why do you want to be a mentor?").lineSpacing(4.0)
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Dark Blue"))

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
