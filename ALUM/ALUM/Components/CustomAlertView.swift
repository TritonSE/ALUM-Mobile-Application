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
        VStack {
            ZStack {
                Circle()
                    .frame(width: 49.78, height: 49.78)
//                    .padding(.top, 19.11)
                    .foregroundColor(isAlert ? Color("ALUM Alert Red") : Color("ALUM Primary Blue"))
                Image(systemName: isAlert ? "exclamationmark" : "questionmark")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 10.11)
                    .padding(.horizontal, 16.33)
                    .padding(.bottom, 9.33)
            }
            Spacer().frame(height: 11.11)
            Text("placeholder title")
            Spacer().frame(height: 8)
            Text("placeholder body")
            Spacer().frame(height: 16)
            HStack(spacing: 16) {
                Button(action: {
                    // Add action for "Close" button here
                }) {
                    Text("Close")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 143, height: 48)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("ALUM Primary Blue"), lineWidth: 2))
                }

                Button(action: {
                    // Add action for "No" button here
                }) {
                    Text("No")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 143, height: 48)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("ALUM Primary Blue"), lineWidth: 2))
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width-32, height: 230)
        .cornerRadius(16)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isAlert: false)
    }
}
