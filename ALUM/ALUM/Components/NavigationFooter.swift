//
//  NavigationFooter.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/8/23.
//

import SwiftUI

struct NavigationFooter: View {
    @State var page: String
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 82)
                .foregroundColor(.white)
            HStack {
                ZStack {
                    if page == "Home"{
                        RoundedRectangle(cornerRadius: 8.0)
                            .frame(width: 64, height: 3)
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .offset(y: -35)
                    }
                    Button {
                    } label: {
                        VStack {
                            Image("ALUM Home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 27)
                                .foregroundColor(Color("ALUM Primary Purple"))
                            Text("Home")
                        }
                        .font(.custom("Metropolis-Regular", size: 10, relativeTo: .caption2))
                    }
                    .foregroundColor(Color("ALUM Primary Purple"))
                }
                .padding(.leading, page == "Home" ? 82 : 98)
                Spacer()
                ZStack {
                    if page == "Profile"{
                        RoundedRectangle(cornerRadius: 8.0)
                            .frame(width: 64, height: 3)
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .offset(y: -35)
                    }
                    Button {
                    } label: {
                        VStack {
                            Image("ALUMLogoBlue")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 27, height: 27)
                            Text("Profile")
                        }
                        .font(.custom("Metropolis-Regular", size: 10, relativeTo: .caption2))
                    }
                    .foregroundColor(Color("ALUM Primary Purple"))
                }
                .padding(.trailing, page == "Profile" ? 82 : 93)
            }
            .padding(.bottom, 25)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom  )
    }
}

struct NavigationFooter_Previews: PreviewProvider {
    static var previews: some View {
        NavigationFooter(page: "Home")
    }
}

