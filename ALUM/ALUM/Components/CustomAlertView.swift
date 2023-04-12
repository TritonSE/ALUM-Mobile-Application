//
//  CustomAlertView.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 4/11/23.
//

import SwiftUI

struct CustomAlertView: View {
    @State var isAlert: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 326, height: 230)
                .foregroundColor(Color.white.opacity(0.5)) // white and remove opacity
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
                Text("placeholder title")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .frame(width: 294, height: 26)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 8)
                Text("All changes have been saved. You can continue editing in “Sessions” tab.")
                    .font(.custom("Metropolis-Regular", size: 13))
                    .frame(width: 294, height: 36)
                    .foregroundColor(Color("NeutralGray4"))
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 16)
                HStack(spacing: 8) {
                    Button(
                        action: {
                            // Add action for "Close" button here
                        },
                        label: {
                            Text("Close")
                                .font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(Color("ALUM Primary Purple"))
                                .font(.system(size: 17, weight: .semibold))
                                .frame(width: 143, height: 48)
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("ALUM Primary Blue"), lineWidth: 2))
                        }
                    )

                    Button(
                        action: {
                            // Add action for "Close" button here
                        },
                        label: {
                            Text("No")
                                .font(.custom("Metropolis-Regular", size: 17))
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .semibold))
                                .frame(width: 143, height: 48)
                                .background(Color.blue)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("ALUM Primary Blue"), lineWidth: 2))
                        }
                    )
                }
            }
        }
//        .background(Color.black.opacity(0.5))
//        .frame(width: 326, height: 230)
//        .cornerRadius(16)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isAlert: true)
    }
}
