//
//  AboutInput.swift
//  ALUM
//
//  Created by Philip Zhang on 5/21/23.
//

import SwiftUI

struct AboutInput: View {
    @Binding var show: Bool
    @Binding var value: String
    @State var temp: String = ""

    func cancel() {
        show = false
    }

    func done() {
        value = temp
        show = false
    }

    var body: some View {
        VStack {
            HStack {
                Text("About")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.bottom, 2)

            Button {
                show = true; temp = value
            } label: {
                ResizingTextBox(text: $value)
            }
            .sheet(isPresented: $show, content: {
                DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                    ParagraphInput(question: "About", text: $temp)
                }
            })
        }
    }
}

struct AboutInput_Previews: PreviewProvider {
    static var previews: some View {
        @State var show = false
        @State var value = ""

        return AboutInput(show: $show, value: $value)
    }
}
