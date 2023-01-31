//
//  InputValidationComponent.swift
//  ALUM
//
//  Created by Harsh Gurnani and Jenny Mar on 1/25/23.
//

import SwiftUI

struct InputValidationComponent: View {
    
    @State var text: String = ""
    var functions: [(String) -> (Bool, String)] = []
    
    var body: some View {
        VStack {
            TextInputFieldComponent(textFieldText: $text, labelText: "Username: ")
            VStack {
                ForEach(0..<functions.count, id: \.self) { index in
                    var result: (Bool, String) = (self.functions[index](text))
                    if (result.0) {
                        InputValidationText(isValid: true, message: result.1)
                    } else {
                        InputValidationText(isValid: false, message: result.1)
                    }
                }
            }
        }
    }
}

struct InputValidationComponent_Previews: PreviewProvider {
    
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
        InputValidationComponent(functions: [testFunction, testFunction2])
    }
}
