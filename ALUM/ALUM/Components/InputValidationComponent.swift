//
//  InputValidationComponent.swift
//  ALUM
//
//  Created by Harsh Gurnani and Jenny Mar on 1/25/23.
//

import SwiftUI

struct InputValidationComponent: View {

    @Binding var text: String
    @State var componentName: Text = Text("")
    @State var labelText: String = ""
    @State var borderColor: Color = Color("NeutralGray3")
    @State var isSecured: Bool = false
    @State var showEye: Bool = false
    @State var showCheck: Bool = false
    var functions: [(String) -> (Bool, String)] = []

    var body: some View {
        VStack {
            TextInputFieldComponent(textFieldText: $text, topLabel: componentName, isSecured: isSecured, showEye: showEye, borderColor: borderColor, labelText: labelText)
            VStack(spacing: 0) {
                ForEach(0..<functions.count, id: \.self) { index in
                    let result: (Bool, String) = (self.functions[index](text))
                    if result.0 {
                        InputValidationText(isValid: true, message: result.1, showCheck: showCheck)
                    } else if !result.0 && result.1 == "skip" {

                    } else {
                        InputValidationText(isValid: false, message: result.1, showCheck: showCheck)
                        // self.borderColor = Color("FunctionalError")
                    }
                }
            }
        }
    }
}

/*
 struct InputValidationComponent_Previews: PreviewProvider {
 
 static var textInput: String = ""
 
 static let testFunction: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
 if (string == "Password") {
 return (true, "good work!")
 } else {
 return (false, "you failed")
 }
 }
 
 static let testFunction2: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
 if (string == "Password") {
 return (true, "good work!")
 } else {
 return (false, "you failed")
 }
 }
 
 static var previews: some View {
 // InputValidationComponent(text: $textInput, functions: [testFunction, testFunction2])
 }
 }
 */
