//
//  CustomNavBar.swift
//  ALUM
//
//  Created by Yash Ravipati on 5/18/23.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let isPurple: Bool
    let alertBar: Bool
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                Image(systemName: "chevron.left")
                    .frame(width: 6, height: 12)
                    .opacity(0)
            }
        }
        .padding()
        .font(.headline)
        .foregroundColor(isPurple ? Color("ALUM Beige") : Color("ALUM Primary Purple"))
        .background(isPurple ?
                     Color("ALUM Primary Purple") : .white)
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(showBackButton: true, title: "Title Here", isPurple: true, alertBar: false)
            Spacer()
        }
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .frame(width: 6, height: 12)
        })
    }
    private var titleSection: some View {
        Text(title)
            .font(.custom("Metropolis-Regular", size: 17))
            .foregroundColor(isPurple ? Color("ALUM Beige") : .black)
    }
}
