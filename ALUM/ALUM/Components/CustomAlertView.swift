//
//  CustomAlertView.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 4/11/23.
//

import SwiftUI

struct CustomAlertView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 49.78, height: 49.78)
                    .padding(.top, 19.11)
                    .foregroundColor(Color("ALUM Primary Blue"))
                Image(systemName: "questionmark")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 10.11)
                    .padding(.horizontal, 16.33)
                    .padding(.bottom, 9.33)
            }
            Spacer()
            Text("Exit [pre/post]-session notes?").foregroundColor(Color.white)
            Spacer()
            Divider()
            HStack {
                Button("Close") { // Button title
                    // Button action
                }.foregroundColor(.white) // Change the title of button
                 .frame(width: UIScreen.main.bounds.width/2-30, height: 40) // Change the frames of button
               
                Button("Ok") { // Button title
                    // Button action
                }.foregroundColor(.white) // Change the title of button
                .frame(width: UIScreen.main.bounds.width/2-30, height: 40) // Change the frames of button
                             
                  }
                    }.frame(width: UIScreen.main.bounds.width-50, height: 200)
                 
                 .background(Color.black.opacity(0.5))
                 .cornerRadius(16)
                 .clipped()
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView()
    }
}
