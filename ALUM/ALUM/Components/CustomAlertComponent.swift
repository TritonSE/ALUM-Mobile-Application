//
//  CustomAlertComponent.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 4/11/23.
//

import SwiftUI

struct CustomAlertComponent: View {
    @State var isAlert: Bool
    let leftButtonLabel: String
    let rightButtonLabel: String
    let titleText: String
    let errorMessage: String
    let leftButtonAction: () -> Void
    let rightButtonAction: () -> Void
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 326, height: 230)
                .foregroundColor(Color.white)
                .cornerRadius(16)

            VStack {
                ZStack {
                    Circle()
                        .frame(width: 49.78, height: 49.78)
                        .foregroundColor(isAlert ? Color("ALUM Alert Red") : Color("ALUM Primary Blue"))
                    Image(systemName: isAlert ? "exclamationmark" : "questionmark")
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(.white)
                        .padding(.top, 10.11)
                        .padding(.horizontal, 16.33)
                        .padding(.bottom, 9.33)
                }
                .padding(.top, 19.11)
                Spacer().frame(height: 11.11)
                Text(titleText)
                    .font(.custom("Metropolis-Regular", size: 17))
                    .frame(width: 294, height: 26)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 8)
                Text(errorMessage)
                    .font(.custom("Metropolis-Regular", size: 13))
                    .frame(width: 294, height: 36)
                    .foregroundColor(Color("NeutralGray4"))
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 16)
                HStack(spacing: 8) {
                    Button(
                        action: {
                            self.leftButtonAction()
                        },
                        label: {
                            Text(leftButtonLabel)
                                .font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(Color("ALUM Primary Purple"))
                                .font(.system(size: 17, weight: .semibold))

                                .cornerRadius(12)
                        }
                    )
                    .buttonStyle(OutlinedButtonStyle())
                    .frame(width: 143, height: 48)
                    Button(
                        action: {
                            self.rightButtonAction()
                        },
                        label: {
                            Text(rightButtonLabel)
                                .font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .semibold))
                                .cornerRadius(12)
                        }
                    )
                    .frame(width: 143, height: 48)
                    .buttonStyle(FilledInButtonStyle())
                }
                .padding(.bottom, 16)
            }
        }
    }
}

struct AlertWithBlurPreviewHelper: View {
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
                CustomAlertComponent(isAlert: true,
                                leftButtonLabel: "Yes, exit",
                                rightButtonLabel: "No",
                                titleText: "Exit [pre/post]-session notes?",
                                errorMessage: "All changes have been saved",
                                leftButtonAction: {
                                    print("Left button pressed!")
                                    showAlert =  false
                },
                                rightButtonAction: { print("Right button pressed!") })
                    .frame(width: 326, height: 230)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 10)
            }
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static func leftButtonAction() {
        print("Left button pressed!")
    }
    static func rightButtonAction() {
        print("Right button pressed!")
    }
    static var previews: some View {
        AlertWithBlurPreviewHelper()
    }
}
