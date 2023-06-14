//
//  EditProfileHeader.swift
//  ALUM
//
//  Created by Philip Zhang on 6/5/23.
//

import SwiftUI

struct EditProfileHeader: View {
    @Environment(\.dismiss) var dismiss
    let saveAction: (() async throws -> Void)

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
                    Task {
                        do {
                            try await saveAction()
                            self.dismiss()
                        } catch AppError.internalError( _, let message) {
                            DispatchQueue.main.async {
                                CurrentUserModel.shared.errorMessage = message
                            }
                        } catch {
                            /// Some other error was thrown
                            DispatchQueue.main.async {
                                CurrentUserModel.shared.showInternalError.toggle()
                            }
                        }
                    }
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
