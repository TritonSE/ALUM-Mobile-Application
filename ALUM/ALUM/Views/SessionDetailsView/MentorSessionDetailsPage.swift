//
//  MentorSessionDetailsPage.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import SwiftUI

struct MentorSessionDetailsHeaderModifier: ViewModifier {
    @State var date: String = ""
    @State var mentee: String = ""

    func body(content: Content) -> some View {
        VStack {
            VStack {
                Text("Session with " + mentee)
                    .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyMentorSessionDetailsHeaderModifier(date: String, mentee: String) -> some View {
        self.modifier(MentorSessionDetailsHeaderModifier(date: date, mentee: mentee))
    }
}

struct MentorSessionDetailsPage: View {
    @StateObject private var viewModel = SessionDetailViewModel()
    @State private var sessionId: String = ""
    var dateFormatter = DateFormatter()

    var body: some View {
        Group {
            if !viewModel.isLoading {
                GeometryReader { grr in
                    VStack {
                        ScrollView {
                            content
                                .padding(.horizontal, 16)
                        }
                        .frame(minHeight: grr.size.height-120)

                        NavigationFooter(page: "Home")
                    }
                    .applyMentorSessionDetailsHeaderModifier(
                        date: viewModel.session.dateTime,
                        mentee: viewModel.session.mentee.mentee.name)
                    .edgesIgnoringSafeArea(.bottom)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.loadSession(sessionID: "6436f55ad2548e9e6503bf7f")
                } catch {
                    print(error)
                }
            }
        }
    }

    var content: some View {
        VStack {
            Group {
                HStack {
                    Text("Mentee")
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("NeutralGray4"))

                    Spacer()
                }
                .padding(.top, 28)
                .padding(.bottom, 20)

                HorizontalMenteeCard(
                    name: viewModel.session.mentee.mentee.name,
                    grade: viewModel.session.mentee.mentee.grade,
                    school: "NHS",
                    isEmpty: true
                )
                .padding(.bottom, 28)
            }

            Group {
                HStack {
                    Text("Date & Time")
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("NeutralGray4"))

                    Spacer()
                }
                .padding(.bottom, 5)

                HStack {
                    Text(viewModel.session.dateTime)
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))

                    Spacer()
                }
                .padding(.bottom, 5)
            }

            if !viewModel.sessionCompleted {
                /*
                Button {
                    
                } label: {
                    Text("Reschedule Session")
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                }
                .buttonStyle(OutlinedButtonStyle())
                .padding(.bottom, 20)
                 */

                Group {
                    HStack {
                        Text("Location")
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("NeutralGray4"))

                        Spacer()
                    }
                    .padding(.bottom, 5)

                    HStack {
                        Text(viewModel.session.mentor.mentor.zoomLink)
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("ALUM Dark Blue"))

                        Spacer()
                    }
                    .padding(.bottom, 20)
                }

                Group {
                    HStack {
                        Text("Pre-Session Form")
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("NeutralGray4"))

                        Spacer()
                    }
                    .padding(.bottom, viewModel.formIsComplete ? 20 : 5)

                    if !viewModel.formIsComplete {
                        HStack {
                            FormIncompleteComponent(type: "Pre")
                            Spacer()
                        }
                        .padding(.bottom, 22)
                    }

                    if !viewModel.formIsComplete {
                        Button {

                        } label: {
                            Text("Complete Pre-Session Notes")
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .padding(.bottom, 5)
                    } else {
                        Button {

                        } label: {
                            Text("View Pre-Session Notes")
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .padding(.bottom, 5)
                    }
                }

                Button {

                } label: {
                    Text("Cancel Session")
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        .foregroundColor(Color("FunctionalError"))
                }
                .buttonStyle(OutlinedButtonStyle())
                .border(Color("FunctionalError"))
                .cornerRadius(8.0)
            } else {
                Group {
                    HStack {
                        Text("Post-Session Form")
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            .foregroundColor(Color("NeutralGray4"))

                        Spacer()
                    }
                    .padding(.bottom, viewModel.formIsComplete ? 20 : 5)

                    if !viewModel.formIsComplete {
                        HStack {
                            FormIncompleteComponent(type: "Post")
                            Spacer()
                        }
                        .padding(.bottom, 22)
                    }

                    if !viewModel.formIsComplete {
                        Button {

                        } label: {
                            Text("Complete Post-Session Notes")
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .padding(.bottom, 5)
                    } else {
                        Button {

                        } label: {
                            Text("View Post-Session Notes")
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .padding(.bottom, 5)
                    }
                }
            }
        }
    }
}

struct MentorSessionDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        MentorSessionDetailsPage()
    }
}
