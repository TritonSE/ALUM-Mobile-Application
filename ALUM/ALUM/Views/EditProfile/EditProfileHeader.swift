//
//  EditProfileHeader.swift
//  ALUM
//
//  Created by Philip Zhang on 6/5/23.
//

import SwiftUI

struct EditProfileHeader: View {
    @Environment(\.dismiss) var dismiss
    let saveAction: (() -> Void)

    var body: some View {
        ZStack {
            HStack {
                Button {
                    self.dismiss()
                } label: {
                    ALUMText(text: "Cancel", fontSize: .smallFontSize, textColor: ALUMColor.primaryPurple)
                }
                .padding(.leading, 16)
                .padding(.top)
                Spacer()
                Button {
                    saveAction()
                    self.dismiss()
                } label: {
                    ALUMText(text: "Save", fontSize: .smallFontSize, textColor: ALUMColor.primaryPurple)
                }
                .padding(.trailing, 16)
                .padding(.top)
                .foregroundColor(Color("ALUM Primary Purple"))
            }
            ALUMText(text: "Edit Profile", textColor: ALUMColor.black)
                .frame(width: 240)
                .padding(.top)
        }
        .padding(.bottom)
        .background(.white)
    }
}

struct EditProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileHeader(saveAction: {})
    }
}
