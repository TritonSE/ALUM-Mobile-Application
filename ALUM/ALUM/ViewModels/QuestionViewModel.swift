//
//  QuestionViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import Foundation

final class QuestionViewModel: ObservableObject {
    @Published var questionList = [Question]
    private var currentIndex: Int = 0
    
    func fetchQuestions() async throws -> [Question] {
        let url = URL(string: "https://example.com/questions")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder ()
        let questions = try decoder. decode( [Question].self, from: data)
        return questions
    }
}
