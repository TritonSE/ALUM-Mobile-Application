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
    @State var year: String = ""

    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)

            VStack {
                StaticProgressBarComponent(nodes: 3, filledNodes: 2, activeNode: 3)
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

                        Menu {
                            Picker(selection: $year, label: Text("Select a year")) {
                                ForEach(1990...2020, id: \.self) {
                                    Text(String($0))
                                }
                            }
                        } label: {
                            HStack {
                                Text("Select a year")
                                Divider()
                                Text(year)
                            }
                        }
                        .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                        .frame(width: 400.0, height: 48.0)
                        .background(
                            Color("ALUM White")
                                .cornerRadius(8.0)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
                        )
                        .padding(.bottom, 32)

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
                                Text("Major")
                                    .font(.custom("Metropolis-Regular", size: 17))
                                    .foregroundColor(Color("ALUM Dark Blue"))

                                Spacer()
                            }
                            .padding(.bottom, 2)
                            .padding(.leading, 16)

                            ZStack {
                                TextField("Career", text: $viewModel.mentor.intendedCareer)
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
                        Button("Back") {
                            dismiss()
                        }
                        .buttonStyle(FilledInButtonStyle(disabled: false))
                        .padding(.trailing, 16)
                        .padding(.bottom, 32)
                        .frame(width: UIScreen.main.bounds.width * 0.3)

                        Button("Continue") {

                        }
                        .buttonStyle(OutlinedButtonStyle(disabled: false))
                        .padding(.bottom, 32)
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
