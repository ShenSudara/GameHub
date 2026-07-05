//
//  QuizRushQuestionModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-05.
//

import Foundation
internal import UIKit

// quiz rush single question model
struct QuizRushQuestionModel: Identifiable, Codable {
    let id = UUID()
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    var answers: [String] {
        ([correctAnswer] + incorrectAnswers).shuffled()
    }
}
