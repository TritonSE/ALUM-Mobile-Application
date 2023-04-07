//
//  RenderTags.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/7/23.
//

import SwiftUI
import WrappingHStack

struct RenderTags: View {
    @State var tags: [String]
    @State var title: String
    var body: some View {
        VStack{
            Text(title)
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
                .foregroundColor(Color("ALUM Dark Blue"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            WrappingHStack(0 ..< tags.count, id: \.self) { index in
                TagDisplay(tagString: tags[index])
                    .padding(.vertical, 5)
            }
        }
    }
}

struct RenderTags_Previews: PreviewProvider {
    static var previews: some View {
        RenderTags(tags: ["Hello", "Chocolate", "SWE", "I like to eat"], title: "Topics")
    }
}
