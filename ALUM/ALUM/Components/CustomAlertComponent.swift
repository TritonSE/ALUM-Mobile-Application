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
                        .foregroundColor(isAlert ? ALUMColor.red.color : ALUMColor.lightBlue.color)
                    Image(systemName: isAlert ? "exclamationmark" : "questionmark")
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(ALUMColor.white.color)
                        .padding(.top, 10.11)
                        .padding(.horizontal, 16.33)
                        .padding(.bottom, 9.33)
                }
                .padding(.top, 19.11)
                Spacer().frame(height: 11.11)
                ALUMText(text: titleText, textColor: ALUMColor.black)
                    .frame(width: 294, height: 26)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 8)
                ALUMText(text: errorMessage, fontSize: .smallFontSize, textColor: ALUMColor.gray4)
                    .frame(width: 294, height: 36)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 16)
                HStack(spacing: 8) {
                    Button(
                        action: {
                            self.leftButtonAction()
                        },
                        label: {
                            ALUMText(text: leftButtonLabel)
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
                            ALUMText(text: rightButtonLabel, textColor: ALUMColor.white)
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
                CustomAlertComponent(isAlert: false,
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

        CustomAlertComponent(
            isAlert: false,
            leftButtonLabel: "Yes, exit",
            rightButtonLabel: "No",
            titleText: "Exit [pre/post]-session notes?",
            errorMessage: "All changes have been saved",
            leftButtonAction: self.leftButtonAction,
            rightButtonAction: self.rightButtonAction
        )

        CustomAlertComponent(
            isAlert: true,
            leftButtonLabel: "Yes, exit",
            rightButtonLabel: "No",
            titleText: "Exit [pre/post]-session notes?",
            errorMessage: "All changes have been saved",
            leftButtonAction: self.leftButtonAction,
            rightButtonAction: self.rightButtonAction
        )
    }
}
