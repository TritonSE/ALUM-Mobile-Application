//
//  SelectUniversityComponent.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/7/23.
//

import SwiftUI

struct SelectUniversityComponent: View {
    @State var searchText = ""
    @State var universityChoice: String = ""
    @Binding var university: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    universityChoice = university
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.custom("Metropolis-Regular", size: 13))
                }

                Spacer()

                Text("College/University")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .padding(.trailing, 16)

                Spacer()

                Button {
                    university = universityChoice
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
                .padding(.top, 16)
                .padding(.bottom, 16)

            HStack {
                Text("Search Results")
                    .font(.custom("Metropolis-Regular", size: 13))
                    .foregroundColor(Color("ALUM Dark Blue"))

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)

            Divider()
                .overlay(Color("ALUM Dark Blue"))
                .padding(.leading, 16)
                .padding(.trailing, 16)

            ScrollView {
                VStack {
                    ForEach(UniversityNames.universityNames, id: \.self) { universityName in
                        if universityName.contains(searchText) || searchText == "" {
                            UniversityRowView(universityName: universityName,
                                              isSelected: universityChoice == universityName
                            )
                            .onTapGesture {
                                universityChoice = universityName
                            }

                            Divider()
                        }
                    }
                }
            }
        }
        .padding(.top, 22)
        .onDisappear {
            university = universityChoice
        }
    }
}

/*
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        ZStack (alignment: .trailing){
            TextField("", text: $text)
                .padding(.init(top: 0.0, leading: 48.0, bottom: 0.0, trailing: 48.0))
                .frame(height: 48)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("ALUM Dark Blue"), lineWidth: 1)
                )
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("NeutralGray3"))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 19)
                        
                        Spacer()
                        
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "xmark" )
                        })
                        .padding(.init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 16.0))
                        .accentColor(Color("NeutralGray4"))
                    }
            )
        }
        .padding(.init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
    }
}
 */

struct UniversityRowView: View {
    var universityName: String = ""
    var isSelected: Bool = false

    var body: some View {
        HStack {
            Text(universityName)
                .font(.custom("Metropolis-Regular", size: 17))
                .padding(.leading, 16)
                .padding(.trailing, 16)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color("ALUM Dark Blue"))
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .background(
            Rectangle()
                .fill(isSelected ? Color("ALUM Light Blue").opacity(0.3) : Color.white)
        )
    }
}

struct SelectUniversityComponent_Previews: PreviewProvider {
    static private var university = Binding.constant("University of California - San Diego")

    static var previews: some View {
        SelectUniversityComponent(university: university)
    }
}
