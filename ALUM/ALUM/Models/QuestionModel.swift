//
//  QuestionModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import Foundation

struct Question: Codable, Hashable, Identifiable {
    var question: String
    var type: String
    var id: String
    var answerBullet: [String]
    var answerCheckboxBullet: [CheckboxBullet]
    var answerParagraph: String

    init(question: String = "", type: String = "", id: String = "", answerBullet: [String] = [],
         answerCheckboxBullet: [CheckboxBullet] = [], answerParagraph: String = "") {
        self.question = question
        self.type = type
        self.id = id
        self.answerBullet = answerBullet
        self.answerCheckboxBullet = answerCheckboxBullet
        self.answerParagraph = answerParagraph
    }
}

struct CheckboxBullet: Codable, Hashable, Identifiable {
    var id = UUID()
    var content: String
    var status: String
}
