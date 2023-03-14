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
    var tagString: String
    let tagIsChecked: Bool
    let itemToggle: () -> Void
    var body: some View {
        HStack {
            Button(action: itemToggle, label: {
                Image(systemName: tagIsChecked ? "checkmark.square" : "square")
                    .padding(.leading, 31)
                    .foregroundColor(Color("ALUM Dark Blue"))
            })
            Text(tagString)
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

struct TagEditor: View {
    @Binding var selectedTags: Set<String>
    @State var searchText = ""
    let predefinedTags =
    ["Tag 1", "Tag 2", "Tag 3", "Tag 4", "Tag 5", "Tag 6", "Tag 7", "Overflow Wrapping", "Tag 8"]
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
            WrappingHStack(selectedTags.sorted(), id: \.self) { tag in
                TagDisplay(
                    tagString: tag,
                    crossShowing: true,
                    crossAction: {
                        self.selectedTags.remove(tag)
                    }
                )
                .padding(.bottom, 16)
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom, 16)
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
                    ForEach(predefinedTags.filter { searchText.isEmpty ?
                        true : $0.localizedCaseInsensitiveContains(searchText) }, id: \.self) { item in
                            ItemDisplay(
                                tagString: item,
                                tagIsChecked: self.selectedTags.contains(item),
                                itemToggle: {
                                    if self.selectedTags.contains(item) {
                                        self.selectedTags.remove(item)
                                    } else {
                                        self.selectedTags.insert(item)
                                    }
                                })
                        Divider()
                            .padding(10)
                            .frame(width: 358)
                    }
                }
            }
//            Spacer()
        }
    }
}

struct PreviewHelper: View {
    @State var selectedTags: Set<String>
    var body: some View {
        TagEditor(selectedTags: $selectedTags)
    }
}

struct TagEditor_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper(selectedTags: Set<String>())
    }
}
