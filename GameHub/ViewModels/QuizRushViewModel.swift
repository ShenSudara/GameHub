//
//  QuizRushViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-05.
//

import Foundation
import Combine

@MainActor
// view model class for quiz rush
final class QuizRushViewModel: ObservableObject {
    @Published private var model: QuizRushModel = QuizRushModel()
    
    // properties for question loading
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let highScoreKey = "QuizRushHighScore"

    init() {
        model.highScore = UserDefaults.standard.integer(forKey: highScoreKey)
    }
    @Published var isGameReset: Bool = true // show and hide game overview
    
    // get the current question
    var currentQuestion: QuizRushQuestionModel? {
        guard model.currentQuestionIndex < model.questions.count else {
            return nil
        }
        return model.questions[model.currentQuestionIndex]
    }
    
    // load list of questions
    func loadQuestions() async {
        isLoading = true
        errorMessage = nil
        model.isGameActive = true
        isGameReset = false

        do {
            let (data, _) = try await URLSession.shared.data(from: QuizRushModel.questionURL)
            let response = try JSONDecoder().decode(QuizRushQuestionResponseModel.self, from: data)

            model.questions = response.results
            model.questions.shuffle()
            model.currentQuestionIndex = 0
            model.score = 0
            model.bonus = 0
            isLoading = false
            errorMessage = ""
        } catch {
            isLoading = false
            errorMessage = "Failed to load questions.\nPlease try again."
        }
    }
    
    // check answer is correct or not
    func selectAnswer(_ answer: String) {
        guard let question = currentQuestion else { return }

        if answer == question.correctAnswer {
            model.bonus += 1
            model.score += 10

            if model.bonus % 3 == 0 {
                model.score += 10
            }
        } else {
            model.bonus = 0
            model.score = max(model.score - 5, 0)
        }

        nextQuestion()
    }

    // iterate to next question
    func nextQuestion() {
        if model.currentQuestionIndex < model.questions.count - 1 {
            model.currentQuestionIndex += 1
        } else {
            model.isGameActive = false
            updateHighScore()
        }
    }

    // restart game
    func restartGame() async {
        model.bonus = 0
        model.currentQuestionIndex = 0
        model.isGameActive = false
        model.score = 0
        errorMessage = ""
        isGameReset = true
        model.questions.removeAll()
    }

    // update the high score
    func updateHighScore(){
        if model.score > model.highScore {
            model.highScore = model.score
            UserDefaults.standard.set(model.highScore, forKey: highScoreKey)
        }
    }

    // get score
    func getScore() -> Int {
        model.score
    }
    
    // get high score
    func getHighScore() -> Int {
        model.highScore
    }
    
    // get is game active
    func isGameActive() -> Bool {
        model.isGameActive
    }
    
    // get current index
    func getCurrentIndex() -> Int {
        model.currentQuestionIndex
    }
    
    // get total question count
    func getTotalQuestionsCount() -> Int {
        model.questions.count
    }
}
