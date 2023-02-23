//
//  BulletComponent.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 2/22/23.
//

import SwiftUI

struct BulletComponent: View {
    @State var isCheckmark: Bool = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 358, height: 42)

            HStack {
                if !isCheckmark {
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(.system(size: 8))
                } else {}

                Spacer()
                    .frame(width: 16)

                Text("Lorem ipsum dolor sit amet")
                    .foregroundColor(.black)

                Button(action: {
                }, label: {
                    Image(systemName: "xmark")
                })
                .foregroundColor(Color("NeutralGray4"))
                .frame(height: 8)
                .frame(width: 8)
            }

        }
    }
}

struct BulletComponent_Previews: PreviewProvider {
    static var previews: some View {
        BulletComponent()
    }
}
