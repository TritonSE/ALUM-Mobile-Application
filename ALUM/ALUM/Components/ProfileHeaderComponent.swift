//
//  ProfileHeaderComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/10/23.
//

import SwiftUI

struct ProfileHeaderComponent: View {
    @State var profile = true
    @State var title: String
    @State var leftText = "Cancel"
    @State var rightText = "Save"
    @State var purple = true
    var body: some View {
        let foreColor = purple ? Color("ALUM White") : Color("ALUM Primary Purple")
        ZStack {
            HStack {
                if !profile {
                    Button {
                    } label: {
                        Text(leftText)
                            .font(Font.custom("Metropolis-Regular", size: 13, relativeTo: .footnote))
                            .foregroundColor(foreColor)
                    }
                    .padding(.leading, 16)
                    .padding(.top)
                } else {
                    Button {
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.leading, 20)
                    .padding(.top)
                    .foregroundColor(foreColor)
                }
                Spacer()
                if !profile {
                    Button {
                    } label: {
                        Text(rightText)
                            .font(Font.custom("Metropolis-Regular", size: 13, relativeTo: .footnote))
                            .foregroundColor(foreColor)
                    }
                    .padding(.trailing, 16)
                    .padding(.top)
                    .foregroundColor(foreColor)
                } else {
                    Button {
                    } label: {
                        if purple {
                            Image("ALUM Pencil White")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19.83, height: 19.83)
                                .padding(.trailing, 20)
                        }
                        else {
                            Image("ALUM Pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19.83, height: 19.83)
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.top)
                    .foregroundColor(foreColor)
                }
            }
            Text(title)
                .frame(width: 240)
                .padding(.top)
                .font(.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .foregroundColor(purple ? Color("ALUM White") : Color.black)
        }
        .padding(.bottom)
    }
}

struct ProfileHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderComponent(title: "My Profile")
    }
}
