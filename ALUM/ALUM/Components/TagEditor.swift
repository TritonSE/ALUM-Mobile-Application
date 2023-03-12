//
//  TagEditor.swift
//  ALUM
//
//  Created by Sidhant Rohatgi on 3/8/23.
//

import SwiftUI
import WrappingHStack

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
    @State var screenTitle: String = "Interests"
    var body: some View {
        TagEditor(items: $tagState, screenTitle: screenTitle)
    }
}

struct TagEditor: View {
    @Binding var items: [TagState]
    @State var searchText = ""
    @Environment(\.dismiss) private var dismiss
    var screenTitle: String = ""

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.custom("Metropolis-Regular", size: 13))
                }

                Spacer()

                Text(screenTitle)
                    .font(.custom("Metropolis-Regular", size: 17))
                    .padding(.trailing, 16)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.custom("Metropolis-Regular", size: 13))
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 13)

            SearchBar(text: $searchText)
                .padding(.bottom, 16)
            if items.filter({ $0.isChecked }).isEmpty {
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
            } else {
                WrappingHStack(items.indices, id: \.self) { idx in
                    if self.items[idx].isChecked {
                        TagDisplay(
                            tagString: self.items[idx].tagString,
                            crossShowing: true,
                            crossAction: {
                                self.items[idx].isChecked = false
                            }
                        )
                        .padding(.bottom, 16)
                    }
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 16)
            }
            Text("Suggestions")
                .padding(.leading, 16)
                .padding(.trailing, 282)
                .foregroundColor(Color("ALUM Dark Blue"))

            Divider()
                .padding(.leading, 16)
                .frame(width: 350, height: 0.5)
                .overlay(Color("ALUM Dark Blue"))
                .padding(.bottom, 10)

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(items.filter { searchText.isEmpty ?
                        true : $0.tagString.localizedCaseInsensitiveContains(searchText) }, id: \.self) { item in
                        ItemDisplay(tagState: self.$items.first(where: { $0.id == item.id })!)
                        Divider()
                            .padding(10)
                            .frame(width: 358)
                    }
                }
            }
        }
    }
}

struct TagEditor_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper(tagState: [
            TagState(tagString: "Tag 1", isChecked: true),
            TagState(tagString: "Tag Text 1", isChecked: true),
            TagState(tagString: "Overflow text 12345", isChecked: true),
            TagState(tagString: "Tag 2", isChecked: true),
            TagState(tagString: "Tag Text 2", isChecked: false),
            TagState(tagString: "Tag 3", isChecked: true)
        ])
    }
}
