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
        .navigationBarBackButtonHidden()
    }
}

struct SetUp: View {
    @ObservedObject var viewModel: SignUpPageViewModel
    
    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)
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

                InputValidationComponent(text: $viewModel.account.email, componentName: Text("Email: ")
                    .font(.custom("Metropolis-Regular", size: 16)), labelText: "Email", showCheck: true, functions: viewModel.emailFunc)
                    .padding(.bottom, 32)

                InputValidationComponent(text: $viewModel.account.name, componentName: Text("Name: ").font(.custom("Metropolis-Regular", size: 16)), labelText: "Name")
                    .padding(.bottom, 32)

                InputValidationComponent(text: $viewModel.account.password, componentName: Text("Password: ")
                    .font(.custom("Metropolis-Reegular", size: 16)), labelText: "Password", isSecured: true, showEye: true, showCheck: true, functions: viewModel.passFunc)
                    .padding(.bottom, 32)

                InputValidationComponent(
                    text: $viewModel.passwordAgain,
                    componentName: Text("Confirm Password: ").font(.custom("Metropolis-Regular", size: 16)),
                    labelText: "Password",
                    isSecured: true,
                    showEye: true,
                    functions:viewModel.passAgainFunc
                )
                .padding(.bottom, 32)
                
                if viewModel.account.email != "" && viewModel.account.password != "" &&
                    viewModel.account.name != "" && viewModel.passwordAgain != "" &&
                    SignUpPageViewModel.Functions.IUSDEmail(viewModel.account.email).0 &&
                    SignUpPageViewModel.Functions.EightChars(viewModel.account.password).0 &&
                    SignUpPageViewModel.Functions.OneNumber(viewModel.account.password).0 &&
                    SignUpPageViewModel.Functions.SpecialChar(viewModel.account.password).0 &&
                    viewModel.account.password == viewModel.passwordAgain
                {
                    NavigationLink(destination: JoinAs(viewModel: viewModel), label: {Text("Continue")})
                    .buttonStyle(FilledInButtonStyle(disabled: false))
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 32)
                } else {
                    Button("Continue") {
                        viewModel.checkPasswordSame()
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
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)
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

                    NavigationLink(destination: MenteeInfo(viewModel: viewModel)) {
                        Text("Continue")
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

struct MenteeInfo: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpPageViewModel
    @State var text: String = ""
    
    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)
                .overlay(alignment: .top) {
                    ProgressBarComponent(nodes: 3, filledNodes: 2, activeNode: 3)
                        .frame(alignment: .top)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                }
            
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
                    Text("Grade")
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Dark Blue"))

                    Spacer()
                }
                .padding(.bottom, 2)
                .padding(.leading, 16)
                
                HStack {
                    GradeComponent(grade: "9", isSelected: false)
                    GradeComponent(grade: "10", isSelected: false)
                    GradeComponent(grade: "11", isSelected: true)
                    GradeComponent(grade: "12", isSelected: false)
                }
                .padding(.bottom, 32)
                
                
                HStack {
                    Text("What do you hope to get out of \nmentorship?")
                        .lineSpacing(4.0)
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Dark Blue"))

                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.bottom, 2)
                
                ZStack {
                    TextField("", text: $text)
                        .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                        .frame(height: 48.0)
                        .background(
                            Color("ALUM White")
                                .cornerRadius(8.0)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
                        )
                }
                .padding(.init(top: 0.0, leading: 16.0, bottom: 67.0, trailing: 16.0))
                
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
            viewModel.setUpMentee()
        }
    }
}

struct MentorInfo: View {
    @Environment(\.dismiss) var dismiss
    @State var year: String = ""
    @State var college: String = ""
    @State var major: String = ""
    @State var minor: String = ""
    @State var career: String = ""
    
    
    var body: some View {
        ZStack {
            Color("ALUM White 2").edgesIgnoringSafeArea(.all)
                .overlay(alignment: .top) {
                    ProgressBarComponent(nodes: 3, filledNodes: 2, activeNode: 3)
                        .frame(alignment: .top)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
            }
            
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
                        TextField("School", text: $college)
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                            .frame(height: 48.0)
                            .background(
                                Color("ALUM White")
                                    .cornerRadius(8.0)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
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
                        TextField("e.g. Economics, Statistics", text: $major)
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                            .frame(height: 48.0)
                            .background(
                                Color("ALUM White")
                                    .cornerRadius(8.0)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
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
                        TextField("e.g. Literature, Psychology", text: $minor)
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                            .frame(height: 48.0)
                            .background(
                                Color("ALUM White")
                                    .cornerRadius(8.0)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
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
                        TextField("Career", text: $career)
                            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                            .frame(height: 48.0)
                            .background(
                                Color("ALUM White")
                                    .cornerRadius(8.0)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8.0).stroke(Color("NeutralGray3"), lineWidth: 1.0)
                            )
                    }
                    .padding(.init(top: 0.0, leading: 16.0, bottom: 32.0, trailing: 16.0))
                }
            }
        }
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

struct GradeComponent: View {
    
    var grade: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
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
            .padding(.leading, 24)
            .padding(.trailing, 10)
            .padding(.top, 14)
            .padding(.bottom, 14)
            
            Text(grade)
                .font(.custom("Metropolis-Regular", size: 17))
                .padding(.trailing, 20)
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(isSelected ? Color("ALUM Light Blue") : Color("ALUM White"))
                    .padding(.trailing, 8)
                    .padding(.leading, 8)
                    .frame(height: 48.0)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(Color("ALUM Light Blue"))
                    .padding(.trailing, 8)
                    .padding(.leading, 8)
                    .frame(height: 48.0)
            }
        )
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView()
        MentorInfo()
    }
}

