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
    @State var showAboutInputSheet: Bool = false

    var body: some View {
        Group {
            if viewModel.isLoading() {
                LoadingView(text: "EditMenteeProfile")
            } else {
                VStack {
                    VStack {
                        NavigationHeaderComponent(
                            backText: "Cancel",
                            backDestination: LoginScreen(),
                            title: "Edit Profile", purple: false
                        )
                    }
                    ScrollView {
                        content
                            .background(Color("ALUM White 2"))
                            .onAppear {
                                careerInterests = Set(viewModel.mentee!.careerInterests)
                                topicsOfInterest = Set(viewModel.mentee!.topicsOfInterest)
                            }
                    }
                }
            }
        }
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

    func handleEditPictureClick() {
        print("handle edit clicked")
    }

    var content: some View {
        VStack {
            HStack {
                Text("Profile Picture")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
                Spacer()
                Button(action: handleEditPictureClick) {
                    Text("Edit")
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Dark Blue"))
                }
            }
            .padding(.top, 25)
            .padding(.leading, 16)
            .padding(.trailing, 16)

            HStack {
                Image("DefaultProfileImage")
            }
            .padding(.top, 10)
            .padding(.bottom, 40)

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

            HStack {
                Text("About")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.bottom, 2)

            AboutInput(show: $showAboutInputSheet, value: viewModel.mentee!.about)

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
            .sheet(isPresented: $careerIsShowing,
                   content: {
                TagEditor(selectedTags: $careerInterests,
                          tempTags: careerInterests,
                          screenTitle: "Career Interests",
                          predefinedTags: CareerInterests.menteeCareerInterests)
                .padding(.top, 22)
            }
            )
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

struct AboutInput: View {
    @Binding var show: Bool
    @State var value: String

    func cancel() {
        show = false
    }

    func done() {
        show = false
    }

    var body: some View {
        Button {
            show = true
        } label: {
            ResizingTextBox(text: $value)
        }
        .sheet(isPresented: $show,
               content: {
            DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                ParagraphInput(question: "About", text: $value)
            }
        }
        )
    }
}

struct EditMenteeProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditMenteeProfileScreen(uID: "6431b99ebcf4420fe9825fe3")
            .onAppear {
                Task {
                    try await FirebaseAuthenticationService.shared
                        .login(email: "mentee@gmail.com", password: "123456")
                }
            }
    }
}
