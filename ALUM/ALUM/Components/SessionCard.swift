//
//  SessionCard.swift
//  ALUM
//
//  Created by Christen Xie on 10/16/23.
//

import SwiftUI

enum SessionCardState{
    case unpaired
    case paired
    case cancelled
    case scheduled
}

struct SessionCard: View {
    
    @State var currentCardState : SessionCardState = .paired
    @State var formIsIncomplete: Bool = false
    @State var formType: String = "Pre"

    var cardBackgroundColor: Color {
        switch currentCardState {
            case .unpaired:
                return Color.white
            case .paired:
                return Color("ALUM Light Purple")
            case .cancelled:
                return Color("ALUM Light Purple")
            case .scheduled:
                return Color.white
            }
    }
    
    var cardHeight: CGFloat{
        switch currentCardState {
            case .unpaired:
                return 100
            case .paired:
                return 180
            case .cancelled:
                return 160
            case .scheduled:
            if(formIsIncomplete){
                return 155
            }
            else{
                return 90
            }
            }
    }
    
    var cardText: String{
        switch currentCardState {
            case .unpaired:
                return "No upcoming sessions"
            case .paired:
                return "You have been paired with Mentor [Mentor Name]. Schedule your first session to meet each other and exchange contacts."
            case .cancelled:
                return "Session with [Mentor name] on [date] at [time] has been cancelled by your mentor."
            case .scheduled:
                return "Complete Pre-Session Notes"
            }
    }
    
    var buttonText: String {
        switch currentCardState {
            case .unpaired:
                return "Book Session via Calendly"
            case .paired:
                return "Book Session via Calendly"
            case .cancelled:
                return "Reschedule via Calendly"
            case .scheduled:
                return "Complete Pre-Session Notes"
            }
    }
    
    var body: some View {
            ZStack {
                if currentCardState == .scheduled {
                    RoundedRectangle(cornerRadius: 12.0)
                        .stroke(Color("ALUM Light Purple"))
                        .frame(width: 358, height: cardHeight)
                } else {
                    RoundedRectangle(cornerRadius: 12.0)
                        .fill(cardBackgroundColor)
                        .frame(width: 358, height: cardHeight)
                        .foregroundColor(Color.white)
                }
            if(currentCardState != .scheduled){
                HStack{
                    VStack{
                        Text(cardText).font(.custom("Metropolis-Regular", size: 20, relativeTo: .headline))
                            .padding(.top)
                            .padding([.leading, .trailing])
                        
                        Spacer()
                        
                        Button(action: {
                                    print("Button was tapped!")
                                }) {
                                    Text(buttonText)
                                        .font(.custom("Metropolis-Regular", size: 20, relativeTo: .headline))
                                        .padding()
                                }
                                .frame(width: 300)
                                .buttonStyle(FilledInButtonStyle(disabled: false))
                                .padding(.bottom)
                                
                    }
                }
                .frame(width: 358, height: cardHeight)
            }else{
                VStack {
                    HStack {
                        VStack {
                            Text("JAN")
                                .font(.custom("Metropolis-Regular", size: 13, relativeTo: .headline))
                                .foregroundColor(Color("TextGray"))
                                .padding(.bottom, 2)
                            Text("23")
                                .font(.custom("Metropolis-Regular", size: 34, relativeTo: .headline))
                        }
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                        VStack{
                            Text("Session with Mentor")
                                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                                .padding(.bottom, 4)
                            
                            HStack {
                                Text("Monday, 9:00 - 10:00 AM PT")
                                    .font(.custom("Metropolis-Regular", size: 13, relativeTo: .headline))
                                    .foregroundColor(Color("TextGray"))
                                    .padding(.bottom, 4)
                               
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("NeutralGray3"))
                            .padding(.trailing, 22)
                    }
                    if formIsIncomplete {
                        HStack{
                            Button(action: {
                                print("Button was tapped!")
                            }) {
                                Text(buttonText)
                                    .font(.custom("Metropolis-Regular", size: 18, relativeTo: .headline))
                                    .padding()
                            }
                            .frame(width: 320, height: 50)
                            .buttonStyle(FilledInButtonStyle(disabled: false))
                            .padding(.bottom, 6)
                        }
                    }
                
                    
                   
                }
                .frame(width: 358, height: cardHeight)
            }
        }
        .padding(.leading, 16).padding(.trailing, 16)
        .padding(.top, 16).padding(.bottom, 16)
    }
}

struct SessionCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        SessionCard()
    }
}
