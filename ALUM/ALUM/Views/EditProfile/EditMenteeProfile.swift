//
//  EditMenteeProfile.swift
//  ALUM
//
//  Created by Philip Zhang on 5/19/23.
//

import SwiftUI
import WrappingHStack

struct EditMenteeProfileScreen: View {
    @StateObject private var viewModel = MenteeProfileViewmodel()
    @State var uID: String = ""
    @State var interestsIsShowing: Bool = false
    @State var careerIsShowing: Bool = false
    @State var careerInterests: Set<String> = []
    @State var topicsOfInterest: Set<String> = []
    @State var about: String = ""
    @State var showAboutInputSheet: Bool = false

    var body: some View {
        Group {
            if viewModel.isLoading() {
                LoadingView(text: "EditMenteeProfile")
            } else {
                VStack {
                    VStack {
                        EditProfileHeader(saveAction: handleSaveClick)
                    }
                    ScrollView {
                        content
                            .background(Color("ALUM White 2"))
                            .onAppear {
                                careerInterests = Set(viewModel.mentee!.careerInterests)
                                topicsOfInterest = Set(viewModel.mentee!.topicsOfInterest)
                                about = viewModel.mentee!.about
                            }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
            Task {
                do {
                    try await viewModel.fetchMenteeInfo(userID: uID)
                } catch {
                    print("Error")
                }
            }
        })
    }

    func handleSaveClick() {
        viewModel.mentee!.about = about
        viewModel.mentee!.careerInterests = Array(careerInterests)
        viewModel.mentee!.topicsOfInterest = Array(topicsOfInterest)
        viewModel.updateMenteeInfo()
    }

    var content: some View {
        VStack {
            EditProfileImage()

            gradeSection

            AboutInput(show: $showAboutInputSheet, value: $about)

            careerInterestsSection

            topicsOfInterestSection
        }
    }

    var gradeSection: some View {
        Group {
            HStack {
                Text("Grade")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
                Spacer()
            }
            .padding(.bottom, 2)
            .padding(.leading, 16)

            HStack {
                ForEach(9...12, id: \.self) { grade in
                    SignUpGradeComponent(grade: String(grade), isSelected: viewModel.mentee!.grade == grade)
                        .onTapGesture {viewModel.mentee!.grade = grade}
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 32)
        }
    }

    var careerInterestsSection: some View {
        Group {
            HStack {
                Text("Career Interests")
                    .lineSpacing(4.0)
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 30)

            Button {
                careerIsShowing = true
            }  label: {
                if careerInterests.isEmpty {
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
                        WrappingHStack(Array(careerInterests), id: \.self) { interest in
                            TagDisplay(
                                tagString: interest,
                                crossShowing: true,
                                crossAction: {
                                    careerInterests.remove(interest)
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
                TagEditor(selectedTags: $careerInterests,
                          tempTags: careerInterests,
                          screenTitle: "Career Interests",
                          predefinedTags: CareerInterests.menteeCareerInterests)
                .padding(.top, 22)
            })
        }
    }

    var topicsOfInterestSection: some View {
        Group {
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
                if topicsOfInterest.isEmpty {
                    HStack {
                        Text("Search to add topics").font(.custom("Metropolis-Regular", size: 17))
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
                        WrappingHStack(Array(topicsOfInterest), id: \.self) { interest in
                            TagDisplay(
                                tagString: interest,
                                crossShowing: true,
                                crossAction: {
                                    topicsOfInterest.remove(interest)
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
                TagEditor(selectedTags: $topicsOfInterest,
                          tempTags: topicsOfInterest,
                          screenTitle: "Topics of Interest",
                          predefinedTags: TopicsOfInterest.topicsOfInterest)
                .padding(.top, 22)
            })
        }
    }
}

struct EditMenteeProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditMenteeProfileScreen(uID: "6431b99ebcf4420fe9825fe3")
                .onAppear {
                    Task {
                        try await FirebaseAuthenticationService.shared
                            .login(email: "mentee@gmail.com", password: "123456")
                    }
                }
        }
    }
}
