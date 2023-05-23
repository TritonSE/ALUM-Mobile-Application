//
//  QuestionViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/9/23.
//

import Foundation
import SwiftUI

final class QuestionViewModel: ObservableObject {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    @Published var questionList: [Question] = []
    @Published var questionListOther: [Question] = []
    @Published var currentIndex: Int = 0
    @Published var lastQuestion: Bool = false
    @Published var isLoading: Bool = true
    @Published var submitSuccess: Bool = false
    @Published var missedOption: String = ""

    func submitNotesPatch(noteID: String) async throws {
        var notesData: [QuestionPatchData] = []

        for question in questionList {
            if question.type ==  "text" {
                notesData.append(QuestionPatchData(answer: PatchAnswer.string(question.answerParagraph),
                                                   type: question.type, questionId: question.id))
            } else if question.type == "bullet" {
                notesData.append(QuestionPatchData(answer: PatchAnswer.listString(question.answerBullet),
                                                   type: question.type, questionId: question.id))
            }
        }
        try await NotesService.shared.patchNotes(noteId: noteID, data: notesData)
    }

    func fetchNotes(noteId: String) async throws {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let notesData: [QuestionGetData] = try await NotesService.shared.getNotes(noteId: noteId)
        var newQuestions: [Question] = []
        for question in notesData {
            var questionToAdd: Question = Question(question: question.question, type: question.type, id: question.id)
            question.answer.toRaw(question: &questionToAdd)
            newQuestions.append(questionToAdd)
        }
        DispatchQueue.main.async {
            self.isLoading = false
            self.questionList = newQuestions
        }
    }

    func loadPostNotes(notesID: String, otherNotesID: String) async throws {
        var notesData: [QuestionGetData] = try await NotesService.shared.getNotes(noteId: notesID)
        var notesDataOther: [QuestionGetData] = try await NotesService.shared.getNotes(noteId: otherNotesID)
        for question in notesData {
            var questionToAdd: Question = Question(question: question.question,
                                                   type: question.type, id: question.id)
            question.answer.toRaw(question: &questionToAdd)
            self.questionList.append(questionToAdd)
        }
        for question in notesDataOther {
            var questionToAdd: Question = Question(question: question.question,
                                                   type: question.type, id: question.id)
            question.answer.toRaw(question: &questionToAdd)
            self.questionListOther.append(questionToAdd)
        }
        self.isLoading = false
        // TODO set currentIndex to 0
    }

    func nextQuestion() {
        self.currentIndex += 1
        if self.currentIndex == self.questionList.count - 1 {
            self.lastQuestion = true
        }
    }

    func prevQuestion() {
        self.currentIndex -= 1
        if self.currentIndex != self.questionList.count - 1 {
            self.lastQuestion = false
        }
    }
}
