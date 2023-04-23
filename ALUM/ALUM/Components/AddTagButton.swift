//
//  AddTagButton.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 2/20/23.
//

import SwiftUI

struct AddTagButton: View {

    @State var text: String = ""
    @Binding var isShowing: Bool

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {isShowing = true}, label: {
                        Spacer()
                            .frame(width: 18)

                        Image(systemName: "plus")
                            .foregroundColor(ALUMColor.primaryPurple.color)

                        Spacer()
                            .frame(width: 14)

                        ALUMText(text: text)
                        Spacer()
                            .frame(width: 12)
                    })
                }

            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 100).stroke())
            .foregroundColor(ALUMColor.lightPurple.color)
            .background(Color(.white))
            .cornerRadius(100)

            }
    }
}

struct AddTagButton_Previews: PreviewProvider {
    static var isShowing = Binding.constant(true)

    static var previews: some View {
        AddTagButton(text: "Sample Text 2 @12345", isShowing: isShowing)
    }
}
