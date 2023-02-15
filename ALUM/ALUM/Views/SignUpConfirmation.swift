//
//  SignUpConfirmation.swift
//  ALUM
//
//  Created by Yash Ravipati on 2/15/23.
//

import SwiftUI

struct SignUpConfirmation: View {
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Button {
                        } label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 6, height: 12)
                            Text("Login")
                                .font(.footnote)
                        }
                        .foregroundColor(Color("ALUM Dark Blue"))
                        Spacer()
                    }
                    .padding(.leading, 25)
                    .padding(.top)
                    Spacer()
                }
                VStack {
                    Text("Sign-Up")
                        .padding()
                        .frame(alignment: .center)
                        .font(.headline)
                    ProgressBarComponent(nodes: 3, filledNodes: 3, activeNode: -1)
                    Spacer()
                }
            }
            ScrollView{
                VStack{
                    HStack{
                        Text("Confirmation")
                            .font(.largeTitle)
                            .foregroundColor(Color("NeutralGray3"))
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                    }
                    .padding(.bottom, 24)
                    HStack{
                        Text("Name: ")
                            .padding(.leading)
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.bottom, 16)
                    HStack{
                        Text("Email: ")
                            .padding(.leading)
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.bottom, 16)
                    HStack{
                        Text("Grade: ")
                            .padding(.leading)
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.bottom, 24)
                    HStack{
                        Text("Topics of Interest:")
                            .padding(.leading)
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            .background(Color("ALUM White"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 114)
                        .foregroundColor(.white)
                    HStack{
                        Button {
                            
                        } label: {
                            Label(
                                title: { Text("Edit") },
                                icon: { Image(systemName: "pencil.line") }
                            )
                        }
                        .buttonStyle(OutlinedButtonStyle())
                        .frame(width: 150)
                        .padding(8)
                        Button("Submit") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                        .buttonStyle(FilledInButtonStyle())
                        .frame(width: 150)
                        .padding(8)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct SignUpConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        SignUpConfirmation()
    }
}
