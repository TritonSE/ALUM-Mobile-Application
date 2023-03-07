//
//  SearchBar.swift
//  ALUM
//
//  Created by Jenny Mar on 2/7/23.
//

import SwiftUI

//struct SearchBar: View {
//    @Binding var text: String
//
//    var body: some View {
//        VStack {
//            TextField("", text: $text)
//                .padding(16)
//                .padding(.horizontal, 25)
//                .background(Color(.white))
//                .cornerRadius(8)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(Color("ALUM Dark Blue"), lineWidth: 1))
//                .padding(.horizontal, 10)
//                .overlay(
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 19)
//                        Button(action: {
//                            text = ""
//                        }, label: {
//                            Image(systemName: "xmark")
//                        })
//                        .padding(.init(top: 0.0, leading: 14.0, bottom: 0.0, trailing: 16.0))
//                        .accentColor(Color("NeutralGray4"))
//                    })
//        }
//    }
//}

// struct Searchable: View {
//    @State private var searchText = ""
//    private var itemsList = [
//        Item(content: "Hello Sentence"),
//        Item(content: "Goodbye Hello"),
//        Item(content: "List Item 3"),
//        Item(content: "Thing 4"),
//        Item(content: "List Item 5")]
//
//    var body: some View {
//        VStack {
//            SearchBar(text: $searchText)
//
//            List(itemsList.filter({ searchText.isEmpty ? true : $0.content.contains(searchText) })) { item in
//                item
//            }
//        }
//    }
// }

// struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        Searchable()
//    }
// }
