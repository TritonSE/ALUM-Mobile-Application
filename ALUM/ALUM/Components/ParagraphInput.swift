//
//  ParagraphInput.swift
//  ALUM
//
//  Created by Jenny Mar on 2/15/23.
//
// call back function exists in parent class
// when its called, it saves the text into the small paragraph
// the method is called when done is pressed
import SwiftUI

struct ParagraphInput: View {
    @State var question: String
    @Binding var text: String

    var body: some View {
        HStack {
            Text(question)
                .font(Font.custom("Metropolis-Regular", size: 17))
                .foregroundColor(Color("ALUM Dark Blue"))
                            Spacer()
        }
        TextEditor(text: $text)
            .font(Font.custom("Metropolis-Regular", size: 17))
            .lineSpacing(6)
            .padding(20)
            .frame(height: 410)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("NeutralGray3"), lineWidth: 1))
            .colorMultiply(Color("ALUM White"))
            .background(Color("ALUM White"))
            .onChange(of: text, perform: { text in
                if text.count > 1000 {
                    self.text = String(text.prefix(1000))
                }
            })
        HStack {
            Spacer()
            Text("\(text.count) / 1000")
                .font(.system(size: 13))
                .foregroundColor(Color("NeutralGray3"))
        }
    }
}

struct ParagraphInputScreen: View {
    @State var data: String = "add text here"
    @State var textFieldText: String = ""

    var body: some View {
        VStack {
            ParagraphInput(question: "Why do you want to be a mentor?", text: $textFieldText)
            // Text(data)
        }
    }
}

struct ParagraphInput_Previews: PreviewProvider {
    static var previews: some View {
        ParagraphInputScreen()
    }
}
