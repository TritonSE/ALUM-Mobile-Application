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
    @State var selectedGrade: Int?

    var body: some View {
//        Group {
//            if viewModel.isLoading() {
//                LoadingView(text: "EditMenteeProfile")
//            } else {
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
                    }
                }
//            }
//        }
//        .onAppear(perform: {
//            Task {
//                do {
//                    try await viewModel.fetchMenteeInfo(userID: uID)
//                } catch {
//                    print("Error")
//                }
//            }
//        })
        //        VStack {
        //            StaticProgressBarComponent(nodes: 3, filledNodes: 0, activeNode: 1)
        //                .background(Color.white)
        //            ScrollView {
        //                content
        //            }
        //            footer
        //                .padding(.horizontal, 16)
        //                .padding(.top, 32)
        //                .padding(.bottom, 40)
        //                .background(Rectangle().fill(Color.white).shadow(radius: 8))
        //        }
        //            .applySignUpScreenHeaderModifier()
        //            .onAppear {
        //                viewModel.emailFunc = [SignUpFlowErrorFunctions.IUSDEmail]
        //                viewModel.passFunc = [SignUpFlowErrorFunctions.EightChars,
        //                                      SignUpFlowErrorFunctions.OneNumber,
        //                                      SignUpFlowErrorFunctions.SpecialChar]
        //            }
        //            .edgesIgnoringSafeArea(.bottom)
    }

    func handleEditPictureClick() {
        print("handle edit clicked")
    }

    var content: some View {
//        var mentee = viewModel.mentee!

        return VStack {
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
                    SignUpGradeComponent(grade: String(grade), isSelected: selectedGrade == grade)
                        .onTapGesture {selectedGrade = grade; }//mentee.grade = grade}
                }

//                SignUpGradeComponent(grade: "10", isSelected: selectedGrade == .ten)
//                    .onTapGesture {selectedGrade = .ten; viewModel.mentee.grade = 10}
//                SignUpGradeComponent(grade: "11", isSelected: selectedGrade == .eleven)
//                    .onTapGesture {selectedGrade = .eleven; viewModel.mentee.grade = 11}
//                SignUpGradeComponent(grade: "12", isSelected: selectedGrade == .twelve)
//                    .onTapGesture {selectedGrade = .twelve; viewModel.mentee.grade = 12}
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

            AboutInput(show: $showAboutInputSheet, value: "mentee.about")

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
                    WrappingHStack(["test", "ygy", "vgjhklk"], id: \.self) { interest in
                        TagDisplay(
                            tagString: interest,
                            crossShowing: true,
                            crossAction: {
                                //viewModel.mentee.careerInterests.removeAll { $0 == interest }
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
                          tempTags: Set<String>(),
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
                    WrappingHStack(["hjk","kjlk"].sorted(), id: \.self) { interest in
                        TagDisplay(
                            tagString: interest,
                            crossShowing: true,
                            crossAction: {
                                //viewModel.mentee.topicsOfInterest.remove(interest)
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
                          tempTags: Set<String>(),
                          screenTitle: "Topics of Interest",
                          predefinedTags: TopicsOfInterest.topicsOfInterest)
                .padding(.top, 22)
            })

        }
    }
}

//

//

//

//

//        }

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
    }
}
