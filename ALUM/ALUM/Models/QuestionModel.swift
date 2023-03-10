//
//  QuestionModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import Foundation

struct Question: Codable {
    var question: String
    var id: String
    var answerBullet: [String]
    var answerParagraph: String
}
