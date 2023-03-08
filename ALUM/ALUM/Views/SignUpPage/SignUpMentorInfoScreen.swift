//
//  SignUpMentorInfoScreen.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/27/23.
//

import SwiftUI

struct SignUpMentorInfoScreen: View {
    @ObservedObject var viewModel: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State var yearIsShowing: Bool = false

    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)

            VStack {

                ProgressBarComponent(nodes: 3, filledNodes: 2, activeNode: 3)
                    .frame(alignment: .top)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.ignoresSafeArea(edges: .top))
                    .frame(maxWidth: .infinity)

                ScrollView {
                    VStack {
                        HStack {
                            Text("Tell us about yourself")
                                .font(.custom("Metropolis-Regular", size: 34))
                                .foregroundColor(Color("NeutralGray3"))
                            Spacer()
                        }
                        .padding(.bottom, 32)
                        .padding(.leading, 16)
                        .padding(.top, 8)

                        HStack {
                            Text("Year of Graduation from Northwood")
                                .font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(Color("ALUM Dark Blue"))

                            Spacer()
                        }
                        .padding(.bottom, 2)
                        .padding(.leading, 16)
                        
                        Button {
                            yearIsShowing = true
                        } label: {
                            HStack {
                                Text(viewModel.mentor.yearOfGrad)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.leading, 16)
                        }
                        .sheet(isPresented: $yearIsShowing,
                            content: {
                            SelectYearComponent(year: $viewModel.mentor.yearOfGrad, yearIsShowing: $yearIsShowing)
                        })
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
                        
                        Group {
                            HStack {
                                Text("College/University")
                                    .font(.custom("Metropolis-Regular", size: 17))
                                    .foregroundColor(Color("ALUM Dark Blue"))

                                Spacer()
                            }
                            .padding(.bottom, 2)
                            .padding(.leading, 16)

                            ZStack {
                                TextField("School", text: $viewModel.mentor.university)
                                    .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                                    .frame(height: 48.0)
                                    .background(
                                        Color("ALUM White")
                                            .cornerRadius(8.0)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8.0)
                                            .stroke(Color("NeutralGray3"), lineWidth: 1.0)
                                    )
                            }
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                        }

                        Group {
                            HStack {
                                Text("Major")
                                    .font(.custom("Metropolis-Regular", size: 17))
                                    .foregroundColor(Color("ALUM Dark Blue"))

                                Spacer()
                            }
                            .padding(.bottom, 2)
                            .padding(.leading, 16)

                            ZStack {
                                TextField("e.g. Economics, Statistics", text: $viewModel.mentor.major)
                                    .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                                    .frame(height: 48.0)
                                    .background(
                                        Color("ALUM White")
                                            .cornerRadius(8.0)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8.0)
                                            .stroke(Color("NeutralGray3"), lineWidth: 1.0)
                                    )
                            }
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                        }

                        Group {
                            HStack {
                                Text("Minor")
                                    .font(.custom("Metropolis-Regular", size: 17))
                                    .foregroundColor(Color("ALUM Dark Blue"))

                                Spacer()
                            }
                            .padding(.bottom, 2)
                            .padding(.leading, 16)

                            ZStack {
                                TextField("e.g. Literature, Psychology", text: $viewModel.mentor.minor)
                                    .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                                    .frame(height: 48.0)
                                    .background(
                                        Color("ALUM White")
                                            .cornerRadius(8.0)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8.0)
                                            .stroke(Color("NeutralGray3"), lineWidth: 1.0)
                                    )
                            }
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                        }

                        Group {
                            HStack {
                                Text("Intended Career")
                                    .lineSpacing(4.0)
                                    .font(.custom("Metropolis-Regular", size: 17))
                                    .foregroundColor(Color("ALUM Dark Blue"))

                                Spacer()
                            }
                            .padding(.bottom, 2)
                            .padding(.leading, 16)

                            ZStack {
                                TextField("e.g. Software Engineer, Product Designer", text: $viewModel.mentor.intendedCareer)
                                    .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                                    .frame(height: 48.0)
                                    .background(
                                        Color("ALUM White")
                                            .cornerRadius(8.0)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8.0)
                                            .stroke(Color("NeutralGray3"), lineWidth: 1.0)
                                    )
                            }
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                        }
                        
                    }
                }

                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 114)
                        .foregroundColor(Color.white)
                        .ignoresSafeArea(edges: .all)

                    HStack {
                        Button{
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Back")
                            }
                        }
                        .buttonStyle(OutlinedButtonStyle(disabled: false))
                        .padding(.trailing, 16)
                        .frame(width: UIScreen.main.bounds.width * 0.3)

                        Button {

                        } label: {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.right")
                            }
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
                .frame(alignment: .bottom)
                .frame(maxWidth: .infinity)
                .background(Color.white.ignoresSafeArea(edges: .bottom))
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarItems(leading: NavigationLink(
            destination: LoginPageView(),
                label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Login")
                            .font(.custom("Metropolis-Regular", size: 13))
                    }
                }
            )
        )
        .navigationBarTitle(Text("Sign-Up").font(.custom("Metropolis-Regular", size: 17)), displayMode: .inline)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.setUpMentor()
        }
    }
}

struct SignUpMentorInfoScreen_Previews: PreviewProvider {
    static private var viewModel = SignUpViewModel()

    static var previews: some View {
        SignUpMentorInfoScreen(viewModel: viewModel)
    }
}
