//
//  AllSessionsPage.swift
//  ALUM
//
//  Created by Neelam Gurnani on 5/27/23.
//

import SwiftUI

struct AllSessionsHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                Text("My Sessions")
                    .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyAllSessionsHeaderModifier() -> some View{
        self.modifier(AllSessionsHeaderModifier())
    }
}

struct AllSessionsPage: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared
    
    var body: some View {
        Group {
            if !currentUser.isLoading {
                NavigationView {
                    GeometryReader { grr in
                        VStack {
                            ScrollView {
                                content
                                    .padding(.horizontal, 16)
                            }
                            .frame(minHeight: grr.size.height-120)
                        }
                        .applyAllSessionsHeaderModifier()
                        .edgesIgnoringSafeArea(.bottom)
                    }
                }
            } else {
                ProgressView()
            }
        }
    }
    
    var content: some View {
        VStack {
            HStack {
                Text("Upcoming")
                    .font(.custom("Metropolis-Regular", size: 22, relativeTo: .headline))
                    .bold()
                
                Spacer()
            }
            .padding(.bottom, 20)
            .padding(.top, 25)
            
            Group {
                ForEach(currentUser.allSessions!, id: \.self) {currSession in
                    if !currSession.hasPassed {
                        if currentUser.role == .mentor {
                            NavigationLink {
                                MentorSessionDetailsPage(sessionID: currSession.id)
                            } label: {
                                SessionButtonComponent(sessionId: currSession.id)
                            }
                            .padding(.bottom, 20)
                        } else {
                            NavigationLink {
                                MenteeSessionsDetailsPage(sessionID: currSession.id)
                            } label: {
                                SessionButtonComponent(sessionId: currSession.id)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .padding(.bottom, 50)
            
            HStack {
                Text("Past")
                    .font(.custom("Metropolis-Regular", size: 22, relativeTo: .headline))
                    .bold()
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            Group {
                ForEach(currentUser.allSessions!, id: \.self) {currSession in
                    if currSession.hasPassed {
                        if currentUser.role == .mentor {
                            NavigationLink {
                                MentorSessionDetailsPage(sessionID: currSession.id)
                            } label: {
                                SessionButtonComponent(sessionId: currSession.id)
                            }
                            .padding(.bottom, 20)
                        } else {
                            NavigationLink {
                                MenteeSessionsDetailsPage(sessionID: currSession.id)
                            } label: {
                                SessionButtonComponent(sessionId: currSession.id)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
        }
    }
}

struct AllSessionsPage_Previews: PreviewProvider {
    static var previews: some View {
        AllSessionsPage()
    }
}
