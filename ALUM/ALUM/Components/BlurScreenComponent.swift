//
//  BlurScreenComponent.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 4/12/23.
//

import SwiftUI

struct BlurScreenComponent: View {
    @State var showAlert = false

    var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
                Text("Hello World")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Button("Show Alert") {
                    showAlert = true
                }
                .padding()
            }
            .blur(radius: showAlert ? 10 : 0)

            if showAlert {
                CustomAlertView(isAlert: false,
                                leftButtonLabel: "Yes, exit",
                                rightButtonLabel: "No",
                                titleText: "Exit [pre/post]-session notes?",
                                errorMessage: "All changes have been saved",
                                leftButtonAction: { print("Left button pressed!") },
                                rightButtonAction: { print("Right button pressed!") })
                    .frame(width: 326, height: 230)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 10)
            }
        }
    }
}

struct BlurScreenComponent_Previews: PreviewProvider {
    static var previews: some View {
        BlurScreenComponent()
    }
}
