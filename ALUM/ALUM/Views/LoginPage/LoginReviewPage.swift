//
//  LoginReviewPage.swift
//  ALUM
//
//  Created by Jenny Mar on 4/25/23.
//

import SwiftUI

struct LoginReviewPage: View {
    @State var text: [String]

    var body: some View {
        VStack {
            Image("ALUMFilledLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 240)
                .padding(37)
            Text(text[0])
                .font(.custom("Metropolis-Regular", size: 34))
                .padding(16)
                .multilineTextAlignment(.center)
            Text(text[1])
                .font(.custom("Metropolis-Regular", size: 17))
                .foregroundColor(Color("NeutralGray4"))
                .multilineTextAlignment(.center)
                .padding(16)
                .lineSpacing(8)
        }
    }
}

struct LoginReviewPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginReviewPage(text: ["Application is under review",
                               "It usually takes 3-5 days to process your application as a mentee."])
    }
}
