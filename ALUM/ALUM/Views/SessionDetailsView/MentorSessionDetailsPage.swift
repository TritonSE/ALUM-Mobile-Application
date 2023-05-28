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
                NavigationHeaderComponent(
                    backText: "",
                    backDestination: LoginScreen(),
                    title: "Session with \(mentee)",
                    purple: false
                )
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
    @State public var showRescheduleAlert = false
    @State public var showCancelAlert = false
    @State public var showCalendly = false
    var body: some View {
        Group {
            if !viewModel.isLoading {
                NavigationView {
                    GeometryReader { grr in
                        VStack {
                            ScrollView {
                                content
                                    .padding(.horizontal, 16)
                            }
                            .frame(minHeight: grr.size.height-120)
                        }
                        .applyMentorSessionDetailsHeaderModifier(
                            date: viewModel.session.date,
                            mentee: viewModel.session.mentee.mentee.name)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                do {
                    var sessionsArray: [UserSessionInfo] = try await SessionService().getSessionsByUser().sessions
                    //try await viewModel.loadSession(sessionID: sessionsArray[0].id
                    try await viewModel.loadSession(sessionID: "646f98a4b083649cc7fdfd73")
                } catch {
                    print(error)
                }
            }
        }
    }

    var content: some View {
        ZStack{
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
                    
                    NavigationLink(destination: MenteeProfileScreen(uID: viewModel.session.mentee.mentee.id)) {
                        HorizontalMenteeCard(
                            name: viewModel.session.mentee.mentee.name,
                            grade: viewModel.session.mentee.mentee.grade,
                            school: "NHS",
                            isEmpty: true
                        )
                        .padding(.bottom, 28)
                    }
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
                        Text(viewModel.session.day + ", " + viewModel.session.date)
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text(viewModel.session.startTime + " - " + viewModel.session.endTime)
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                
                if !viewModel.sessionCompleted {
                    
                    Button {
                        showRescheduleAlert = true
                    } label: {
                        Text("Reschedule Session")
                            .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    }
                    .buttonStyle(OutlinedButtonStyle())
                    .padding(.bottom, 20)
                    
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
                        
                        NavigationLink {
                            ViewPreSessionNotesPage(notesID: viewModel.session.preSessionID)
                        } label: {
                            Text("View Pre-Session Notes")
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .padding(.bottom, 5)
                    }
                    
                    Button {
                        showCancelAlert = true
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
                            NavigationLink {
                                PostSessionView(
                                    notesID: viewModel.session.mentorPostSessionID,
                                    otherNotesID: viewModel.session.menteePostSessionID,
                                    otherName: viewModel.session.mentee.mentee.name,
                                    date: viewModel.session.date,
                                    time: viewModel.session.startTime
                                )
                            } label: {
                                Text("Complete Post-Session Notes")
                                    .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                            }
                            .buttonStyle(FilledInButtonStyle())
                            .padding(.bottom, 5)
                        } else {
                            NavigationLink {
                                ViewPostSessionNotesPage(
                                    notesID: viewModel.session.mentorPostSessionID,
                                    otherNotesID: viewModel.session.menteePostSessionID,
                                    otherName: viewModel.session.mentee.mentee.name,
                                    date: viewModel.session.date,
                                    time: viewModel.session.startTime
                                )
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
            .blur(radius: showRescheduleAlert || showCancelAlert ? 10 : 0)
            if showRescheduleAlert {
                CustomAlertView(isAlert: true,
                                leftButtonLabel: "Yes, reschedule",
                                rightButtonLabel: "No",
                                titleText: "Reschedule this session?",
                                errorMessage: "Your pre-session notes will be transferred to your next scheduled session",
                                leftButtonAction: {
                    print(showCalendly)
                    print("Left button pressed")
                    showCalendly = true
                }, rightButtonAction: {
                    showRescheduleAlert = false
                })
                .frame(width: 326, height: 230)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
            }
            NavigationLink(destination: CalendlyView(requestType: "PATCH", sessionId: viewModel.sessionID), isActive: $showCalendly) {
            }
            .hidden()
            
            if showCancelAlert {
                CustomAlertView(isAlert: true,
                                leftButtonLabel: "Yes, cancel it",
                                rightButtonLabel: "No",
                                titleText: "Cancel this session?",
                                errorMessage: "Your pre-session notes will be lost",
                                leftButtonAction: {
                    Task{
                        do {
                            try await SessionService().deleteSessionWithId(sessionId: viewModel.sessionID)
                        } catch {
                            print(error)
                        }
                    }
                }, rightButtonAction: {
                    showCancelAlert = false
                })
                .frame(width: 326, height: 230)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
            }
        }
    }
}

struct MentorSessionDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        MentorSessionDetailsPage()
    }
}
