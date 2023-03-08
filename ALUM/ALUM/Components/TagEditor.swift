//
//  TagEditor.swift
//  ALUM
//
//  Created by Aman Aggarwal on 3/6/23.
//

import SwiftUI

struct TagState: Hashable, Identifiable {
    var id = UUID()
    var name: String = ""
    let tagString: String
    var isChecked: Bool
    func hash(into hasher: inout Hasher) {
        hasher.combine(tagString)
        hasher.combine(isChecked)
    }
}

struct ItemDisplay: View {
    @Binding var tagState: TagState
    var body: some View {
        HStack {
            Button(action: {
                tagState.isChecked = !tagState.isChecked
            }, label: {
                Image(systemName: tagState.isChecked ? "checkmark.square" : "square")
                    .padding(.leading, 31)
                    .foregroundColor(Color("ALUM Dark Blue"))
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

struct TagEditor: View {
    @Binding var items: [TagState]
    @State var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.bottom, 16)
            // CHANGE TO WRAPPING HSTACK AND ADD MORE BUTTON
            HStack(alignment: .firstTextBaseline) {
                ForEach(items.indices, id: \.self) { idx in
                    if self.items[idx].isChecked {
                        TagDisplay(
                            tagString: self.items[idx].tagString,
                            crossShowing: true,
                            crossAction: {
                                self.items[idx].isChecked = false
                            }
                        )
                    }
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 32)
            
            Text("Suggestions")
                .padding(.leading, 16)
                .padding(.trailing, 282)
                .foregroundColor(Color("ALUM Dark Blue"))
            
            Divider()
                .padding(.leading, 16)
                .frame(width: 350, height: 0.5)
                .overlay(Color("ALUM Dark Blue"))
                .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                ForEach(items.filter { searchText.isEmpty ? true : $0.tagString.localizedCaseInsensitiveContains(searchText) }, id: \.self) { item in
                    ItemDisplay(tagState: self.$items.first(where: { $0.id == item.id })!)
                    Divider()
                        .padding(10)
                        .frame(width: 358)
                }
            }
            Spacer()
        }
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
