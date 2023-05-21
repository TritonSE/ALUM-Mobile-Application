//
//  EditProfileImage.swift
//  ALUM
//
//  Created by Philip Zhang on 5/21/23.
//

import SwiftUI

struct EditProfileImage: View {
    func handleEditPictureClick() {
        print("handle edit clicked")
    }

    var body: some View {
        VStack {
            HStack {
                Text("Profile Picture")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
                Spacer()
                Button(action: handleEditPictureClick) {
                    Text("Edit")
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Dark Blue"))
                }
            }
            .padding(.top, 25)
            .padding(.leading, 16)
            .padding(.trailing, 16)

            HStack {
                Image("DefaultProfileImage")
            }
            .padding(.top, 10)
            .padding(.bottom, 40)
        }
    }
}

struct EditProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileImage()
    }
}
