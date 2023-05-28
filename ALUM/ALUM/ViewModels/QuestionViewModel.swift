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

    func submitMissedNotesPatch(noteID: String) async throws {
        var notesData: [QuestionPatchData] = []
        notesData.append(QuestionPatchData(answer: PatchAnswer.string(missedOption),
                                           type: "text", questionId: "missedSessionQuestionId"))
        try await NotesService.shared.patchNotes(noteId: noteID, data: notesData)
    }
    
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

    func fetchNotes(noteId: String) async throws -> [Question] {
        let notesData: [QuestionGetData] = try await NotesService.shared.getNotes(noteId: noteId)
        var newQuestions: [Question] = []
        for question in notesData {
            var questionToAdd: Question = Question(question: question.question, type: question.type, id: question.id)
            question.answer.toRaw(question: &questionToAdd)
            newQuestions.append(questionToAdd)
        }
        return newQuestions
    }
    
    func fetchPreSessionNotes(noteId: String) async throws {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let questions = try await self.fetchNotes(noteId: noteId)
        DispatchQueue.main.async {
            self.isLoading = false
            self.questionList = questions
        }
    }

    func fetchPostSessionNotes(notesId: String, otherNotesId: String) async throws {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let primaryQuestions = try await self.fetchNotes(noteId: notesId)
        let otherQuestions = try await self.fetchNotes(noteId: otherNotesId)
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.questionList = primaryQuestions
            self.questionListOther = otherQuestions
        }
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
