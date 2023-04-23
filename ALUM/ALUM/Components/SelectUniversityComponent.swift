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
                    ALUMText(text: "Cancel", fontSize: .smallFontSize)
                }

                Spacer()

                ALUMText(text: "College/University", textColor: ALUMColor.black)
                    .padding(.trailing, 16)

                Spacer()

                Button {
                    university = universityChoice
                    dismiss()
                } label: {
                    ALUMText(text: "Done", fontSize: .smallFontSize)
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 13)

            SearchBar(text: $searchText)
                .padding(.top, 16)
                .padding(.bottom, 16)

            HStack {
                ALUMText(text: "Search Results", fontSize: .smallFontSize)

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)

            Divider()
                .overlay(ALUMColor.primaryPurple.color)
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

struct UniversityRowView: View {
    var universityName: String = ""
    var isSelected: Bool = false

    var body: some View {
        HStack {
            ALUMText(text: universityName, textColor: ALUMColor.black)
                .padding(.leading, 16)
                .padding(.trailing, 16)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(ALUMColor.primaryPurple.color)
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .background(
            Rectangle()
                .fill(isSelected ? ALUMColor.lightPurple.color.opacity(0.3) : ALUMColor.white.color)
        )
    }
}

struct SelectUniversityComponent_Previews: PreviewProvider {
    static private var university = Binding.constant("University of California - San Diego")

    static var previews: some View {
        SelectUniversityComponent(university: university)
    }
}
