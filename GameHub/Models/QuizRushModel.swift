//
//  QuizRushModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-05.
//

import Foundation

struct QuizRushModel{
    // game configurations
    static let questionURL = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!
    
    // game properties
    var questions: [QuizRushQuestionModel] = []
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    var highScore: Int = 0
    var bonus: Int = 0
    var isGameActive: Bool = false
}
