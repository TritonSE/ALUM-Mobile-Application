//
//  MentorSessionDetailsPage.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import SwiftUI

struct MentorSessionDetailsHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            VStack {
                Text("[Date] Session with [Mentee]")
                    .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            content
                .background(Color("ALUM White 2"))
        }
    }
}

extension View {
    func applyMentorSessionDetailsHeaderModifier() -> some View {
        self.modifier(MentorSessionDetailsHeaderModifier())
    }
}

struct MentorSessionDetailsPage: View {
    @StateObject private var viewModel = SessionDetailViewModel()
    
    var body: some View {
        GeometryReader { grr in
            VStack {
                ScrollView {
                    content
                        .padding(.horizontal, 16)
                }
                .frame(minHeight: grr.size.height-120)

                NavigationFooter(page: "Home")
            }
            .applyMenteeSessionDetailsHeaderModifier()
            .edgesIgnoringSafeArea(.bottom)
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
                
                HorizontalMenteeCard(isEmpty: true)
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
                    Text("Monday, January 23, 2023")
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("9:00 - 10:00 AM PT")
                        .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                    
                    Spacer()
                }
                .padding(.bottom, 10)
            }
            
            if !viewModel.sessionCompleted {
                Button {
                    
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
                        Text("https://alum.zoom.us/my/timby")
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
