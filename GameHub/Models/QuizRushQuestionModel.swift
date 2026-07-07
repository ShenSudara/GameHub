//
//  QuizRushQuestionModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-05.
//

import Foundation
internal import UIKit

// extension for decode response string
private extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        ) else {
            return self
        }

        return attributedString.string
    }
}

// quiz rush single question model
struct QuizRushQuestionModel: Identifiable, Codable {
    let id: UUID
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.question = try container.decode(String.self, forKey: .question).htmlDecoded
        self.correctAnswer = try container.decode(String.self, forKey: .correctAnswer).htmlDecoded
        self.incorrectAnswers = try container.decode([String].self, forKey: .incorrectAnswers)
            .map(\.htmlDecoded)
    }
    
    var answers: [String] {
        ([correctAnswer] + incorrectAnswers).shuffled()
    }
}
