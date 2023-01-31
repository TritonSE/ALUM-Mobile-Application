//
//  LoginPageView.swift
//  ALUM
//
//  Created by Harsh Gurnani on 1/31/23.
//

import SwiftUI

struct LoginPageView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        VStack {
            Image("ALUMLogoBlue")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            
            Text("Welcome to ALUM")
                // .font(.largeTitle)
                .font(Font.custom("Metropolis-Thin", size: 34))
                .foregroundColor(Color("ALUM Dark Blue"))
                .frame(width: 306, height: 41)
            
            InputValidationComponent(componentName: Text("Email: "), labelText: "Email", functions: [Functions.EnterEmail])
            
            InputValidationComponent(componentName: Text("Password: "), labelText: "Password", functions: [Functions.EnterPassword])
            
            
            
        }
    }
}

class Functions {
    static let EnterEmail: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        if (string == "") {
            return (false, "Please enter your email")
        } else {
            return (false, "skip")
        }
    }
    
    static let EnterPassword: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
        if (string == "") {
            return (false, "Please enter your password")
        } else {
            return (false, "skip")
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
