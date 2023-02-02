//
//  TextInputFieldView.swift
//  ALUM
//
//  Created by Harsh Gurnani and Sidhant Rohatgi on 1/18/23.
//

import SwiftUI

struct TextInputFieldComponent: View {
    @Binding var textFieldText: String
    @State var topLabel: Text = Text("")
    @State var isSecured: Bool = false
    @State var showEye: Bool = false
    @State var borderColor: Color = Color("NeutralGray3")
    var labelText: String = ""

    var body: some View {

        VStack {
            HStack {
                topLabel
                    .font(Font.custom("Metropolis-Thin", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
                Spacer()
            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))

            ZStack(alignment: .trailing) {
                Group {
                    if isSecured {
                        SecureField(labelText, text: $textFieldText)
                    } else {
                        TextField(labelText, text: $textFieldText)
                    }
                }
                .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                .frame(height: 48.0)
                .background(
                    Color("ALUM White")
                        .cornerRadius(8.0)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0).stroke(borderColor, lineWidth: 1.0)
                )

                if showEye {
                    Button(action: {
                        isSecured.toggle()
                    }, label: {
                        Image(systemName: isSecured ? "eye.slash" : "eye")
                            .accentColor(Color("NeutralGray4"))
                    })
                    .padding(.init(top: 0.0, leading: 14.0, bottom: 0.0, trailing: 14.0))
                }

            }
            .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
        }
    }
}

struct TestView: View {

    @State var textInput: String = ""

    var body: some View {
        VStack {
            TextInputFieldComponent(textFieldText: $textInput, isSecured: false, showEye: false, labelText: "Username:")
            Text(textInput)
        }

    }
}

struct TextInputFieldView_Previews: PreviewProvider {

    static var previews: some View {
        TestView()
    }
}
