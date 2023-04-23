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
            ALUMText(text: question)
            Spacer()
        }
        TextEditor(text: $text)
            .padding(20)
            .frame(height: 410)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(ALUMColor.gray3.color, lineWidth: 1))
            .colorMultiply(ALUMColor.white.color)
            .background(ALUMColor.white.color)
            .onChange(of: text, perform: { text in
                if text.count > 1000 {
                    self.text = String(text.prefix(1000))
                }
            })
        HStack {
            Spacer()
            ALUMText(text: "\(text.count) / 1000", fontSize: .smallFontSize, textColor: ALUMColor.gray3)
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
