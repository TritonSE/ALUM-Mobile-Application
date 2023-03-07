//
//  Item.swift
//  ALUM
//
//  Created by Jenny Mar on 2/1/23.
//

import SwiftUI

struct Item: View, Hashable, Identifiable {

    var id = UUID()
    var name: String = ""

    // requirements to make Hashable
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.isChecked == rhs.isChecked && lhs.content == rhs.content
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(isChecked)
        hasher.combine(content)
    }

    // variables
    @State var content: String = ""
    @Binding var isChecked: Bool

    func toggle() {
        isChecked = !isChecked
    }

    var body: some View {
        HStack {
            Button(action: toggle, label: {
                Image(systemName: isChecked ? "checkmark.square" : "square")
            })
            Text(content)

        }

    }
}
//
//struct ItemTester: View {
//    @State var stringList: [String]
//    @State var isChecked: [(String, Bool)] // TagStatus
//    @State var itemsList: [Item]
//
//    var body: some View {
//
//        VStack(alignment: .leading) {
//
//            HStack {
//                ForEach(itemsList, id: \.self) { itm in
//                    if itm.isChecked {
//                        TagDisplay(text: itm.content, crossShowing: true)
//                    }
//                }
//            }
//            .padding(.bottom, 10)
//            Divider()
//                .padding(10)
//                .frame(width: 300, height: 0.5)
//                .overlay(Color("ALUM Dark Blue"))
//            ForEach(itemsList, id: \.self) { itm in
//                itm
//                Divider()
//                    .padding(10)
//                    .frame(width: 300)
//            }
//        }
//    }
//}

//struct Item_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemTester(itemsList:
//                    [Item(content: "list item 1", isChecked: true),
//                     Item(content: "list item 2", isChecked: true),
//                     Item(content: "list item 3", isChecked: false)])
//    }
//}
