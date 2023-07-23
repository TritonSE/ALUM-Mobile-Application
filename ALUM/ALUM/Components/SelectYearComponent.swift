//
//  SelectYearComponent.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/7/23.
//

import SwiftUI

struct SelectYearComponent: View {
    @Binding var year: Int
    @State var yearChoice: Int = 0
    @State var showIsDone: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    yearChoice = year
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.custom("Metropolis-Regular", size: 13))
                }

                Spacer()

                Text("Year of Graduation from...")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .padding(.trailing, 16)

                Spacer()

                Button {
                    year = yearChoice
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.custom("Metropolis-Regular", size: 13))
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)

            Divider()

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(1990..<2024) { graduationYear in
                        YearRowView(graduationYear: graduationYear,
                                isSelected: yearChoice == graduationYear
                        )
                        .onTapGesture {
                            yearChoice = graduationYear
                            showIsDone = true
                        }

                        Divider()
                    }
                }
            }
        }
        .padding(.top, 22)
        .onDisappear {
            year = yearChoice
        }
    }
}

struct YearRowView: View {
    var graduationYear: Int
    var isSelected: Bool

    var body: some View {
        HStack {
            Text(String(graduationYear))
                .font(.custom("Metropolis-Regular", size: 17))
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

struct SelectYearComponent_Previews: PreviewProvider {
    static private var startYear = 2020
    static private var year = Binding.constant(2020)

    static var previews: some View {
        SelectYearComponent(year: year)
    }
}
