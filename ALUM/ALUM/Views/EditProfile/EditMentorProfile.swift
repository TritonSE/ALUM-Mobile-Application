//
//  EditMentorProfile.swift
//  ALUM
//
//  Created by Philip Zhang on 5/21/23.
//

import SwiftUI
import WrappingHStack

struct EditMentorProfileScreen: View {
    @StateObject private var viewModel = MentorProfileViewModel()
    @State var uID: String = ""
    @State var expertiseIsShowing: Bool = false
    @State var topicsOfExpertise: Set<String> = []
    @State var showAboutInputSheet: Bool = false
    @State var yearIsShowing: Bool = false
    @State var mentor: MentorInfo = MentorInfo(id: "", name: "", imageId: "", about: "",
                                               calendlyLink: "", personalAccessToken: "", zoomLink: "",
                                               graduationYear: 0, college: "", major: "", minor: "", career: "",
                                               topicsOfExpertise: [])

    var body: some View {
        Group {
            if viewModel.isLoading() {
                LoadingView(text: "EditMentorProfile")
            } else {
                VStack {
                    VStack {
                        NavigationHeaderComponent(
                            backText: "Cancel",
                            backDestination: MentorProfileScreen(uID: uID),
                            title: "Edit Profile", purple: false
                        )
                    }
                    ScrollView {
                        content
                            .background(Color("ALUM White 2"))
                            .onAppear {
                                mentor = viewModel.mentor!
                                topicsOfExpertise = Set(mentor.topicsOfExpertise)
                            }
                    }
                }
            }
        }
        .onAppear(perform: {
            Task {
                do {
                    try await viewModel.fetchMentorInfo(userID: uID)
                } catch {
                    print("Error")
                }
            }
        })
    }

    func handleSaveClick() {
        mentor.topicsOfExpertise = Array(topicsOfExpertise)
        viewModel.mentor! = mentor
        viewModel.updateMentorInfo()
    }

    var content: some View {
        VStack {
            calendlyZoomSection

            EditProfileImage()

            detailsSection

            AboutInput(show: $showAboutInputSheet, value: $mentor.about)

            topicsOfExpertiseSection

            Button {
                handleSaveClick()
            }  label: {
                Text("Save")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
            }

        }
    }

    var calendlyZoomSection: some View {
        VStack {
            ALUMTextFieldComponent(title: "Calendly Link",
                                   suggestion: "eg. https://calendly.com/timby",
                                   text: $mentor.calendlyLink)

            ALUMTextFieldComponent(title: "Calendly Access Token",
                                   suggestion: "ey...",
                                   text: $mentor.personalAccessToken,
                                   isSecure: true)

            ALUMTextFieldComponent(title: "Zoom Link",
                                   suggestion: "eg. https://ucsd.zoom.us/t/1234567890",
                                   text: $mentor.zoomLink)
        }
        .padding(.top, 20)
    }

    var detailsSection: some View {
        Group {
            ALUMTextFieldComponent(title: "Major",
                                   suggestion: "e.g. Economics, Statistics",
                                   text: $mentor.major)

            ALUMTextFieldComponent(title: "Minor",
                                   suggestion: "e.g. Literature, Psychology",
                                   text: $mentor.minor)

            ALUMTextFieldComponent(title: "College / University",
                                   suggestion: "e.g. University of California, San Diego",
                                   text: $mentor.college)

            ALUMTextFieldComponent(title: "Intended Career",
                                   suggestion: "e.g. Data Scientist",
                                   text: $mentor.career)

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
                        if mentor.graduationYear != 0 {
                            Text(String(mentor.graduationYear)).foregroundColor(.black)
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
                SelectYearComponent(year: $mentor.graduationYear,
                                    yearChoice: mentor.graduationYear)
            })
            .frame(height: 48.0)
            .background(Color("ALUM White").cornerRadius(8.0))
            .overlay(
                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
            )
            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
        }
    }

    var topicsOfExpertiseSection: some View {
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
                if topicsOfExpertise.isEmpty {
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
                        WrappingHStack(topicsOfExpertise.sorted(),
                                       id: \.self) { topic in
                            TagDisplay(
                                tagString: topic,
                                crossShowing: true,
                                crossAction: {
                                    topicsOfExpertise.remove(topic)
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
                TagEditor(selectedTags: $topicsOfExpertise,
                          tempTags: topicsOfExpertise,
                          screenTitle: "Topics of Expertise",
                          predefinedTags: TopicsOfInterest.topicsOfInterest)
                .padding(.top, 22)
            })
        }
    }
}

struct EditMentorProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditMentorProfileScreen(uID: "6431b9a2bcf4420fe9825fe5")
            .onAppear {
                Task {
                    try await FirebaseAuthenticationService.shared
                        .login(email: "mentor@gmail.com", password: "123456")
                }
            }
    }
}
