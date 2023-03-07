//
//  TagEditor.swift
//  ALUM
//
//  Created by Aman Aggarwal on 3/6/23.
//

import SwiftUI

struct TagState: Hashable {
    let tagString: String
    var isChecked: Bool
    func hash(into hasher: inout Hasher) {
        hasher.combine(tagString)
        hasher.combine(isChecked)
    }
}

struct TagEditor: View {
    @Binding var items: [TagState]
    @State private var searchText = ""
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.bottom, 16)
            HStack(alignment: .firstTextBaseline) { // change to wrapping HStack
                ForEach(items.indices, id: \.self) { idx in
                    if self.items[idx].isChecked {
                        TagDisplay(
                            tagString: self.items[idx].tagString,
                            crossShowing: true,
                            crossAction: {
                                self.items[idx].isChecked = !self.items[idx].isChecked
                            }
                        )
                    }
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom)
            VStack(alignment: .leading) {
                ForEach(items.indices, id: \.self) { idx in
                    ItemDisplay(tagState: self.$items[idx])
                    Divider()
                        .padding(10)
                        .frame(width: 358)
                }
            }
            Spacer() // Might have to remove
        }
    }
}

struct ItemDisplay: View {
    // Update Styling for each row (with checkbox)
    @Binding var tagState: TagState
    var body: some View {
        HStack {
            Button(action: {
                tagState.isChecked = !tagState.isChecked
            }, label: {
                Image(systemName: tagState.isChecked ? "checkmark.square" : "square")
                    .padding(.leading, 31)
            })
            Text(tagState.tagString)
        }

    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        VStack {
            TextField("", text: $text)
                .padding(16)
                .padding(.horizontal, 25)
                .background(Color(.white))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("ALUM Dark Blue"), lineWidth: 1))
                .padding(.horizontal, 10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 19)
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "xmark")
                        })
                        .padding(.init(top: 0.0, leading: 14.0, bottom: 0.0, trailing: 16.0))
                        .accentColor(Color("NeutralGray4"))
                    })
        }
    }
}

struct PreviewHelper: View {
    @State var tagState: [TagState]
    var body: some View {
        TagEditor(items: $tagState)
    }
}
struct TagEditor_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper(tagState: [
            TagState(tagString: "Tag 1", isChecked: true),
            TagState(tagString: "Tag 2", isChecked: false),
            TagState(tagString: "Tag 3", isChecked: false),
            TagState(tagString: "Overflow text 12345", isChecked: true)
        ])
    }
}
