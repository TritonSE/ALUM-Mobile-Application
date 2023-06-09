//
//  SessionConfirmationScreen.swift
//  ALUM
//
//  Created by Jenny Mar on 4/11/23.
//

import SwiftUI

struct ConfirmationScreen: View {
    @State var text: [String] // [primary text, subtext, button text]
    var userLoggedIn = true

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(
                                colors: [Color("GradientGreen"), Color("GradientBlue")]),
                                           startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 213.33, height: 213.33)
                        .rotationEffect(Angle(degrees: 315))
                        .padding(37)
                    Image(systemName: "checkmark")
                        .font(.system(size: 100, weight: .black))
                        .foregroundColor(.white)
                }

                Text(text[0])
                    .font(.custom("Metropolis-Regular", size: 34))
                    .padding(16)
                    .multilineTextAlignment(.center)
                Text(text[1])
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("NeutralGray4"))
                    .multilineTextAlignment(.center)
                    .padding(16)

                Spacer()
                CustomNavLink(
                    destination: userLoggedIn ? AnyView(LoggedInRouter(defaultSelection: 0)) : AnyView(LoginScreen()),
                    label: {
                        HStack {
                            Text(text[2])
                                .font(.custom("Metropolis-Regular", size: 17))
                        }
                    }
                )
                .buttonStyle(FilledInButtonStyle(disabled: false))
                .padding(.bottom, 32)
                .frame(width: geometry.size.width * 0.9)
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .frame(alignment: .bottom)
            .frame(maxWidth: .infinity)
        }
        .navigationBarBackButtonHidden()
    }
}

struct SessionConfirmationTester: View {
    @State var text: [String] = [
        "Missed session form submitted!",
        "Thank you for your feedback!",
        "Close"]
    var body: some View {
        ConfirmationScreen(text: text)
    }
}

struct SessionConfirmationScreen_Previews: PreviewProvider {
    static var previews: some View {
        SessionConfirmationTester()
    }
}
