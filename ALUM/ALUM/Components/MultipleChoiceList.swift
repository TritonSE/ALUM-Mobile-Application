//
//  MultipleChoiceList.swift
//  ALUM
//
//  Created by Jenny Mar on 4/5/23.
//

import SwiftUI

struct MultipleChoice: View {
    var content: String
    var checked: Bool
    @Binding var otherText: String
    var body: some View {
        if content == "Other:" {
            HStack {
                ZStack {
                    Circle()
                        .strokeBorder(Color("ALUM Dark Blue"), lineWidth: 2)
                        .background(Circle().fill(.white))
                        .frame(width: 20, height: 20)
                        .padding(.init(top: 14.0, leading: 34, bottom: 14.0, trailing: 10))
                    Circle()
                        .strokeBorder(checked ? Color("ALUM Dark Blue") : Color(.white), lineWidth: 2)
                        .background(Circle().fill(checked ? Color("ALUM Dark Blue") : Color(.white)))
                        .frame(width: 8, height: 8)
                        .padding(.init(top: 14.0, leading: 34, bottom: 14.0, trailing: 10))
                }

                Text(content)
                    .font(Font.custom("Metropolis-Regular", size: 17))
                    .padding(.init(top: 11, leading: 0, bottom: 11, trailing: 2))
                TextField("", text: $otherText)
                    .padding(.leading, 22)
                    .padding(.trailing, 22)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12.0)
                                .fill(checked ? Color("ALUM Light Blue") : Color("ALUM White"))
                                .padding(.trailing, 8)
                                .padding(.leading, 8)
                                .frame(height: 48.0)

                            RoundedRectangle(cornerRadius: 12.0)
                                .stroke(Color("ALUM Dark Blue"))
                                .padding(.trailing, 8)
                                .padding(.leading, 8)
                                .frame(height: 48.0)
                        })

                Spacer()
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)

                    .stroke(Color("ALUM Dark Blue"), lineWidth: 1)
                    .frame(width: 358, height: 48)
                HStack {
                    ZStack {
                        Circle()
                            .strokeBorder(Color("ALUM Dark Blue"), lineWidth: 2)
                            .background(Circle().fill(.white))
                            .frame(width: 20, height: 20)
                            .padding(.init(top: 14.0, leading: 34, bottom: 14.0, trailing: 10))
                        if checked == true {
                            Circle()
                                .strokeBorder(Color("ALUM Dark Blue"), lineWidth: 2)
                                .background(Circle().fill( Color("ALUM Dark Blue")))
                                .frame(width: 8, height: 8)
                                .padding(.init(top: 14.0, leading: 34, bottom: 14.0, trailing: 10))
                        }
                    }
                    Text(content)
                        .font(Font.custom("Metropolis-Regular", size: 17))
                        .padding(.init(top: 11, leading: 0, bottom: 11, trailing: 16))
                    Spacer()
                }
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(checked ? Color("ALUM Light Blue") : Color("ALUM White"))
                            .padding(.trailing, 16)
                            .padding(.leading, 16)
                            .frame(height: 48.0)

                        RoundedRectangle(cornerRadius: 12.0)
                            .stroke(Color("ALUM Dark Blue"))
                            .padding(.trailing, 16)
                            .padding(.leading, 16)
                            .frame(height: 48.0)
                    })
            }

        }

    }
}

struct MultipleChoiceView: View {
    @State var answerChoices: [String] = ["Mentor/ee and I decided to cancel",
                                          "I had an emergency",
                                          "I forgot about the session",
                                          "Mentor/ee didn't show up",
                                          "Other:",
                                          "Prefer not to say"]
    @State var otherText: String = ""
    // index selected var
    var body: some View {
        VStack {
            MultipleChoice(content: "hello", checked: false, otherText: $otherText)
            MultipleChoice(content: "goodbye", checked: false, otherText: $otherText)
            MultipleChoice(content: "Other:", checked: false, otherText: $otherText)
            Text(otherText)
        }

    }
}

struct MultipleChoiceList_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView()
    }
}
