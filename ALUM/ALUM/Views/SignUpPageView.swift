//
//  SignUpPageView.swift
//  ALUM
//
//  Created by Neelam Gurnani on 2/17/23.
//

import SwiftUI

struct SignUpPageView: View {

    @StateObject private var viewModel = SignUpPageViewModel()

    var body: some View {
        NavigationView {
            SetUp(viewModel: viewModel)
        }
    }
}

struct SetUp: View {
    @ObservedObject var viewModel: SignUpPageViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                .overlay(alignment: .top) {
                    ProgressBarComponent(nodes: 3, filledNodes: 0, activeNode: 1)
                        .frame(alignment: .top)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                }
            VStack {
                HStack {
                    Text("Account Set-Up")
                        .font(.custom("Metropolis-Regular", size: 34))
                        .foregroundColor(Color("NeutralGray3"))
                        .frame(width: 306, height: 41)
                    Spacer()
                }
                .padding(.bottom, 32)

                InputValidationComponent(text: $viewModel.email, componentName: Text("Email: ")
                    .font(.custom("Metropolis-Regular", size: 16)), labelText: "Email", showCheck: true, functions: viewModel.emailFunc)
                    .padding(.bottom, 32)

                InputValidationComponent(text: $viewModel.name, componentName: Text("Name: ").font(.custom("Metropolis-Regular", size: 16)), labelText: "Name")
                    .padding(.bottom, 32)

                InputValidationComponent(text: $viewModel.password, componentName: Text("Password: ")
                    .font(.custom("Metropolis-Reegular", size: 16)), labelText: "Password", showCheck: true, functions: viewModel.passFunc)
                    .padding(.bottom, 32)

                InputValidationComponent(text: $viewModel.passwordAgain, componentName: Text("Confirm Password: ").font(.custom("Metropolis-Regular", size: 16)), labelText: "Password")
                    .padding(.bottom, 32)

                if viewModel.email != "" && viewModel.password != "" {
                    NavigationLink(destination: JoinAs(viewModel: viewModel), label: {Text("Continue")})
                    .buttonStyle(FilledInButtonStyle(disabled: false))
                    .frame(width: 358)
                    .padding(.bottom, 32)
                } else {
                    Button("Continue") {
                        
                    }
                    .buttonStyle(FilledInButtonStyle(disabled: true))
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 32)
                }

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
        .navigationBarTitle("Sign Up", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.emailFunc = [SignUpPageViewModel.Functions.IUSDEmail]
            viewModel.passFunc = [SignUpPageViewModel.Functions.EightChars, SignUpPageViewModel.Functions.OneNumber, SignUpPageViewModel.Functions.SpecialChar]
        }
    }
}

struct JoinAs: View {

    enum JoinType {
        case mentee
        case mentor
    }
    
    @ObservedObject var viewModel: SignUpPageViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectedType: JoinType? = nil
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                .overlay(alignment: .top) {
                    ProgressBarComponent(nodes: 3, filledNodes: 1, activeNode: 2)
                        .frame(alignment: .top)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                }
            VStack {
                HStack {
                    Text("I want to join as a...")
                        .font(.custom("Metropolis-Regular", size: 34))
                        .foregroundColor(Color("NeutralGray3"))
                        .frame(width: 306, height: 41)
                        .padding(.top, 8)
                    Spacer()
                }
                .padding(.bottom, 32)

                JoinOptionView(title: "Mentee",
                               description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                               isSelected: selectedType == .mentee)
                    .onTapGesture {
                        selectedType = .mentee
                        viewModel.isMentee = true
                        viewModel.isMentor = false
                    }
                    .padding(.bottom, 32)
                
                JoinOptionView(title: "Mentor",
                               description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                               isSelected: selectedType == .mentor)
                    .onTapGesture {
                        selectedType = .mentor
                        viewModel.isMentee = false
                        viewModel.isMentor = true
                    }
                    .padding(.bottom, 137)

                HStack {
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(FilledInButtonStyle(disabled: false))
                    .padding(.bottom, 32)

                    Button("Continue") {
                        
                    }
                    .buttonStyle(OutlinedButtonStyle(disabled: false))
                    .padding(.bottom, 32)
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
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
        .navigationBarTitle("Sign Up", displayMode: .inline)
        .navigationBarBackButtonHidden()
    }
}

struct JoinOptionView: View {

    var title: String
    var description: String
    var isSelected: Bool
    
    var body: some View {

        VStack {
            HStack {
                Text(title)
                    .font(.custom("Metropolis-Regular", size: 34))
                Spacer()
                
                ZStack {
                    Circle()
                        .strokeBorder(Color("ALUM Dark Blue"), lineWidth: 2.0)
                        .frame(width: 20, height: 20)
                    
                    if isSelected {
                        Circle()
                            .fill(Color("ALUM Dark Blue"))
                            .frame(width: 4, height: 4)
                    }
                }
                
                 
            }
            .padding(.leading, 32)
            .padding(.trailing, 32)
            .padding(.bottom, 8)
            .padding(.top, 16)

            Text(description)
                .font(.custom("Metropolis-Regular", size: 17))
                .lineSpacing(4.0)
                .padding(.leading, 32)
                .padding(.trailing, 32)
                .padding(.bottom, 16)
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(isSelected ? Color("ALUM Light Blue") : Color.white)
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(Color("ALUM Light Blue"))
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
            }
        )
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView()
    }
}

