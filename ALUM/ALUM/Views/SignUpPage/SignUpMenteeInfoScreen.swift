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

    @State var selectedGrade: GradeType?
    @State var allMenteeInterests: [TagState] = TopicsOfInterest.topicsOfInterestTags
    @State var allCareerInterests: [TagState] = CareerInterests.menteeCareerInterestsTags

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
                            Text("Topics of Interest")
                                .lineSpacing(4.0)
                                .font(.custom("Metropolis-Regular", size: 17))
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
                                    Text("Search to add topics")
                                        .font(.custom("Metropolis-Regular", size: 17))
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
                                    WrappingHStack(viewModel.mentee.topicsOfInterest.indices, id: \.self) { idx in
                                        if viewModel.mentee.topicsOfInterest[idx].isChecked {
                                            TagDisplay(
                                                tagString: viewModel.mentee.topicsOfInterest[idx].tagString,
                                                crossShowing: false,
                                                crossAction: {
                                                    viewModel.mentee.topicsOfInterest[idx].isChecked = false
                                                }
                                            )
                                            .padding(.bottom, 16)
                                        }
                                    }
                                }
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom, 32)
                                .padding(.top, 14)
                            }
                        }
                        .sheet(isPresented: $interestsIsShowing,
                               onDismiss: {
                                    viewModel.mentee.topicsOfInterest = []
                                    for idx in allMenteeInterests.indices {
                                        if allMenteeInterests[idx].isChecked {
                                            viewModel.mentee.topicsOfInterest.append(allMenteeInterests[idx])
                                        }
                                    }
                                    interestsIsShowing = false
                                },
                               content: {
                                    TagEditor(items: $allMenteeInterests, screenTitle: "Topics of Interest")
                                        .padding(.top, 22)
                                }
                        )

                        HStack {
                            Text("Career Interests")
                                .lineSpacing(4.0)
                                .font(.custom("Metropolis-Regular", size: 17))
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
                                    Text("Search to add interests")
                                        .font(.custom("Metropolis-Regular", size: 17))
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
                                    WrappingHStack(viewModel.mentee.careerInterests.indices, id: \.self) { idx in
                                        if viewModel.mentee.careerInterests[idx].isChecked {
                                            TagDisplay(
                                                tagString: viewModel.mentee.careerInterests[idx].tagString,
                                                crossShowing: false,
                                                crossAction: {
                                                    viewModel.mentee.topicsOfInterest[idx].isChecked = false
                                                }
                                            )
                                            .padding(.bottom, 16)
                                        }
                                    }
                                }
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom, 32)
                                .padding(.top, 14)
                            }
                        }
                        .sheet(isPresented: $careerIsShowing,
                               onDismiss: {
                                    viewModel.mentee.careerInterests = []
                                    for idx in allCareerInterests.indices {
                                        if allCareerInterests[idx].isChecked {
                                            viewModel.mentee.careerInterests.append(allCareerInterests[idx])
                                        }
                                    }
                                    careerIsShowing = false
                                },
                               content: {
                                    TagEditor(items: $allCareerInterests, screenTitle: "Career Interests")
                                        .padding(.top, 22)
                                }
                        )

                        Group {
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
                }

                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 114)
                        .foregroundColor(Color.white)
                        .ignoresSafeArea(edges: .all)

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

                        Button {

                        } label: {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.right")
                            }
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
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
