//
//  QuestionViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import Foundation

final class QuestionViewModel: ObservableObject {
    @Published var questionList: [Question] = []
    @Published var currentIndex: Int = 0
    @Published var lastQuestion: Bool = false
    @Published var isLoading: Bool = true
    @Published var missedOption: String = ""
    
    func loadTestData() {
        print("load test data")
//        var question1 = Question(question: "Testing Question 1", type: "text", id: "1", answerBullet: [], answerCheckboxBullet: [],
//                                 answerParagraph: "Testing Answer 1")
//        var question2 = Question(question: "Testing Question 2", type: "text", id: "2", answerBullet: [], answerCheckboxBullet: [],
//                                 answerParagraph: "Testing Answer 2")
//        var question3 = Question(question: "Testing Question 3",
//                                 type: "bullet",
//                                 id: "3",
//                                 answerBullet:
//                                    ["Testing a really long line so I can make sure it wraps around as it should",
//                                     "Answer", "3"],
//                                 answerCheckboxBullet: [],
//                                 answerParagraph: "")
//        var question4 = Question(question: "Testing Question 4",
//                                 type: "bullet",
//                                 id: "4",
//                                 answerBullet:
//                                    ["Some other possible answers",
//                                     "Blah Blah Blah", "Longer answer to make this look long Longer answer to make this look long"],
//                                 answerCheckboxBullet: [],
//                                 answerParagraph: "")
        var question5 = Question(question: "Testing Question 5",
                                 type: "checkbox-bullet",
                                 id: "5",
                                 answerBullet: [],
                                 answerCheckboxBullet:
                                    ["checked": "checked text here",
                                     "unchecked": "unchecked text here",
                                     "bullet": "bulleted text here"],
                                 answerParagraph: "")
        var question6 = Question(question: "Testing Question 6",
                                 type: "bullet",
                                 id: "5",
                                 answerBullet: ["bullet 1", "bullet 2"],
                                 answerCheckboxBullet: [:],
                                 answerParagraph: "")

        self.questionList.append(question5)
        self.questionList.append(question6)
//        self.questionList.append(question2)
//        self.questionList.append(question3)
//        self.questionList.append(question4)
        self.isLoading = false
    }

    func fetchQuestions() async throws -> [Question] {
        let url = URL(string: "http://localhost:3000/notes/")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let questions = try decoder.decode( [Question].self, from: data)
        return questions
    }

    func nextQuestion() {
        self.currentIndex += 1
        if (self.currentIndex == self.questionList.count - 1) {
            self.lastQuestion = true
        }
    }
    
    func prevQuestion() {
        self.currentIndex -= 1
        if (self.currentIndex != self.questionList.count - 1) {
            self.lastQuestion = false
        }
    }
    
    class Functions {
        static let enterMissedOption: (String) -> (Bool, String) = {(string: String) -> (Bool, String) in
            if string == "" {
                return (false, "Please enter your email")
            } else {
                return (false, "skip")
            }
        }
    }
    
}
