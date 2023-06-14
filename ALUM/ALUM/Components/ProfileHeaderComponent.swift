//
//  ProfileHeaderComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/10/23.
//

import SwiftUI

struct ProfileHeaderComponent<Destination: View>: View {
    @State var editDestination: Destination

    var body: some View {
        ZStack {
            HStack {
                //                    Button {
                //                    } label: {
                //                        Image(systemName: "gearshape")
                //                            .resizable()
                //                            .scaledToFit()
                //                            .frame(width: 20, height: 20)
                //                    }
                //                    .padding(.leading, 20)
                //                    .padding(.top)
                //                    .foregroundColor(foreColor)
                Spacer()
                NavigationLink(destination: editDestination) {
                        Image("ALUM Pencil White")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 19.83, height: 19.83)
                            .padding(.trailing, 20)
                }
                .padding(.top)
                .foregroundColor(Color("ALUM White"))
            }
            ALUMText(text: "My Profile", textColor: ALUMColor.white)
                .frame(width: 240)
                .padding(.top)
        }
        .padding(.bottom)
        .background(Color("ALUM Primary Purple"))
    }
}

struct ProfileHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderComponent(editDestination: EmptyView())
    }
}
