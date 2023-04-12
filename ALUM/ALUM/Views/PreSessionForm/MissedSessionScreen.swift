//
//  MissedSessionScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 4/5/23.
//

import SwiftUI

struct MissedSessionScreen: View {
    enum OptionType {
        case cancelled
        case emergency
        case forgot
        case notShowed
        case other
        case notSay
    }

    @ObservedObject var viewModel: QuestionViewModel
    @Environment(\.dismiss) var dismiss
    @State var validated: Bool = true
    @State var selectedOption: OptionType?
    @State var noOption: Bool = false
    @State var otherEmpty: Bool = false
    @State var otherText: String = ""
   
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("ALUM White 2").edgesIgnoringSafeArea(.all)
                VStack {
                    ScrollView {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("ALUM Light Blue"))
                                Text("It seems that your session with [Mentor/mentee Name] on [date] at [time] didn't happen.")
                                    .font(.custom("Metropolis-Regular", size: 17))
                                    .lineSpacing(10)
                                    .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                            }
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                            .padding(.bottom, 32)
                            .padding(.top, 8)

                            HStack {
                                Text("What went wrong?")
                                    .font(.custom("Metropolis-Regular", size: 17))
                                    .foregroundColor(Color("ALUM Dark Blue"))
                                    .padding(.init(top: 0, leading: 16, bottom: 3, trailing: 16))
                                Spacer()
                            }
                            if noOption == true {
                                HStack {
                                    Text("Please select an option")
                                        .font(.custom("Metropolis-Regular", size: 13))
                                        .foregroundColor(Color("FunctionalError"))
                                        .padding(.init(top: 0, leading: 16, bottom: 8, trailing: 16))
                                    Spacer()
                                }
                            }
                            else if otherEmpty == true {
                                HStack {
                                    Text("Please fill in Other")
                                        .font(.custom("Metropolis-Regular", size: 13))
                                        .foregroundColor(Color("FunctionalError"))
                                        .padding(.init(top: 0, leading: 16, bottom: 8, trailing: 16))
                                    Spacer()
                                }
                            }

                            MultipleChoice(content: "Mentor/ee and I decided to cancel", checked: selectedOption == .cancelled, otherText: $otherText)
                                .onTapGesture {selectedOption = .cancelled; viewModel.missedOption = "Mentor/ee and I decided to cancel"; noOption = false; otherEmpty = false}
                                .padding(.bottom, 12)
                            MultipleChoice(content: "I had an emergency", checked: selectedOption == .emergency, otherText: $otherText)
                                .onTapGesture {selectedOption = .emergency; viewModel.missedOption = "I had an emergency"; noOption = false; otherEmpty = false}
                                .padding(.bottom, 12)
                            MultipleChoice(content: "I forgot about the session", checked: selectedOption == .forgot, otherText: $otherText)
                                .onTapGesture {selectedOption = .forgot; viewModel.missedOption = "I forgot about the session"; noOption = false; otherEmpty = false}
                                .padding(.bottom, 12)
                            MultipleChoice(content: "Other:", checked: selectedOption == .other, otherText: $otherText)
                                .onTapGesture {selectedOption = .other; viewModel.missedOption = otherText; noOption = false}
                                .padding(.bottom, 12)
                            MultipleChoice(content: "Prefer not to say", checked: selectedOption == .notSay, otherText: $otherText)
                                .onTapGesture {selectedOption = .notSay; viewModel.missedOption = "Prefer not to say"; noOption = false; otherEmpty = false}
                                .padding(.bottom, 12)
                            
                                //Text(viewModel.missedOption)
                            
                        }
                    }
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 114)
                            .foregroundColor(Color.white)
                            .ignoresSafeArea(edges: .all)
                        if viewModel.missedOption != "" {
                            NavigationLink(destination: SessionConfirmationScreen(sessionType: "missed"), label: {
                                HStack {
                                    Text("Submit")
                                        .font(.custom("Metropolis-Regular", size: 17))
                                }
                            })
                            .buttonStyle(FilledInButtonStyle(disabled: false))
                            .padding(.bottom, 32)
                            .frame(width: geometry.size.width * 0.92)
                        }
                        
                        else {
                            if selectedOption == .other {
                                
                            } else {
                                
                            }
                            Button("Submit") {
                                if selectedOption == .other {
                                    otherEmpty = true
                                } else {
                                    noOption = true
                                }
                            }
                            .font(.custom("Metropolis-Regular", size: 17))
                            .buttonStyle(FilledInButtonStyle(disabled: true))
                            .padding(.bottom, 32)
                            .frame(width: geometry.size.width * 0.92)
                        }

                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .frame(alignment: .bottom)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.ignoresSafeArea(edges: .bottom))
                        
                }
                .onAppear {
                    if viewModel.missedOption == "Mentor/ee and I decided to cancel" {
                        selectedOption = .cancelled
                    } else if viewModel.missedOption == "I had an emergency" {
                        selectedOption = .emergency
                    } else if viewModel.missedOption == "I forgot about the session" {
                        selectedOption = .forgot
                    } else if viewModel.missedOption == "Other" {
                        selectedOption = .other
                    } else if viewModel.missedOption == "Prefer not to say" {
                        selectedOption = .notSay
                    }
                }
            }
            .navigationBarItems(leading: NavigationLink(
                destination: PostSessionQuestionScreen(viewModel: viewModel),
                label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Cancel")
                            .font(.custom("Metropolis-Regular", size: 13))
                    }
                }
            ))
            .navigationBarTitle(Text("Missed Session").font(.custom("Metropolis-Regular", size: 17)),
                                displayMode: .inline)
            .navigationBarBackButtonHidden()
        }
    }
}

struct MissedSessionScreen_Previews: PreviewProvider {
    static private var viewModel = QuestionViewModel()

    static var previews: some View {
        MissedSessionScreen(viewModel: viewModel)
    }
}
