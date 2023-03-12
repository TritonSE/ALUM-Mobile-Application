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
    @Published var lastQuestion: Bool = true

    func loadTestData() -> [Question] {
        var questions: [Question] = []

        var question1 = Question(question: "Testing Question 1", type: "text", id: "1", answerBullet: [],
                                 answerParagraph: "Testing Answer 1")
        var question2 = Question(question: "Testing Question 2", type: "text", id: "2", answerBullet: [],
                                 answerParagraph: "Testing Answer 2")
        var question3 = Question(question: "Testing Question 3", type: "text", id: "3", answerBullet: [],
                                 answerParagraph: "Testing Answer 3")

        questions.append(question1)
        questions.append(question2)
        questions.append(question3)

        return questions
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
    }
}
