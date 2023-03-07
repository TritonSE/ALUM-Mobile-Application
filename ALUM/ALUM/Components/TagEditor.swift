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
    var body: some View {
        VStack {
            HStack {
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
            }
            VStack {
                ForEach(items.indices, id: \.self) { idx in
                    ItemDisplay(tagState: self.$items[idx])
                }
            }
        }
    }
}

struct ItemDisplay: View {
    // TODO Update Styling for each row (with checkbox)
    @Binding var tagState: TagState
    var body: some View {
        HStack {
            Button(action: {
                tagState.isChecked = !tagState.isChecked
            }, label: {
                Image(systemName: tagState.isChecked ? "checkmark.square" : "square")
            })
            Text(tagState.tagString)
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
            TagState(tagString: "Tag 2", isChecked: false)
        ])
    }
}
