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
    var answerParagraph: String
    
    init(question: String = "", type: String = "", id: String = "", answerBullet: [String] = [], answerParagraph: String = "") {
        self.question = question
        self.type = type
        self.id = id
        self.answerBullet = answerBullet
        self.answerParagraph = answerParagraph
    }
}
