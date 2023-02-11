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
    @State var isChecked: Bool = false

    func toggle () {
        isChecked = !isChecked

    }

    var body: some View {
        HStack {
            Button(action: toggle) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
            }
            Text(content)

        }

//        if (isChecked) {
//            SearchableTags(text: content, isBlue: true)
//        }
    }
}

struct ItemTester: View {

    @State var itemsList = [Item(content: "")]

    var body: some View {

        VStack(alignment: .leading) {

            HStack {
                ForEach(itemsList, id: \.self) { itm in
                    if itm.isChecked {
                        Tags(text: itm.content, isBlue: true)
                    }
                }
            }

            Divider()
                .padding(10)
                .frame(width: 300)
            ForEach(itemsList, id: \.self) { itm in
                itm
                Divider()
                    .padding(10)
                    .frame(width: 300)

            }
        }

    }

}

struct Item_Previews: PreviewProvider {
    static var previews: some View {
        ItemTester(itemsList:
                    [Item(content: "list item 1", isChecked: false),
                     Item(content: "list item 2", isChecked: true),
                     Item(content: "list item 3", isChecked: true)])
    }
}
