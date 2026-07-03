//
//  TapFrenzyViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

import Foundation
import Combine

// view model class for tap frenzy
final class TapFrenzyViewModel: ObservableObject {
    @Published private var model = TapFrenzyModel()
    @Published var isGameReset: Bool = true // show, hide gameoverview
    private var timer: Timer?
    private var colorTimer: Timer?

    private let highScoreKey = "TapFrenzyHighScore"

    init() {
        model.highScore = UserDefaults.standard.integer(forKey: highScoreKey)
    }
    
    // increase the game score
    func incrementScore() {
        guard model.isGameActive else { return }
        
        let currentTime = Date()
        if self.model.lastTapTime != nil{
            let interval = currentTime.timeIntervalSince(self.model.lastTapTime!)
            if interval <= 0.5 {
                self.model.multiplier += 1
                self.model.isMultiplying = true
            } else {
                self.model.multiplier = 1
                self.model.isMultiplying = false
            }
        }else{
            self.model.multiplier = 1
            self.model.isMultiplying = false
        }
        
        // button color change logic and according to color multiplier change logic
        let currentMultiplier = self.model.multiplier
        switch self.model.tapButtonColor {
        case .yellow:
            self.model.multiplier = currentMultiplier * 2
            self.model.isMultiplying = self.model.multiplier > 1
            model.score += self.model.multiplier
        case .gray:
            model.score = max(0, model.score - currentMultiplier)
        case .normal:
            model.score += currentMultiplier
        }
        
        model.lastTapTime = currentTime
    }
        
    // start the game
    func startGame() {
        // stop the timer if there any inprogress
        resetGame()
        isGameReset = false
        model.isGameActive = true
        model.tapButtonColor = randomButtonColor()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard self.model.isGameActive else { return }

            if self.model.timeRemaining > 0 {
                self.model.timeRemaining -= 1
                
                //check the multiplier when time counting
                guard self.model.lastTapTime != nil else { return }
                if Date().timeIntervalSince(self.model.lastTapTime!) > 0.5 {
                    self.model.multiplier = 1
                    self.model.isMultiplying = false
                }
            } else {
                self.stopTimer()
                self.stopColorTimer()
                self.model.isGameActive = false
                
                // after game end reset multiplier
                self.model.multiplier = 1
                self.model.isMultiplying = false
                self.model.lastTapTime = nil
                
                // update the high score
                updateHighScore()
            }
        }

        // color timer for color changing
        colorTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard self.model.isGameActive else { return }
            self.model.tapButtonColor = self.randomButtonColor()
        }
    }
    
    // high score update logic
    func updateHighScore() {
        if model.score > model.highScore{
            model.highScore = model.score
            UserDefaults.standard.set(model.highScore, forKey: highScoreKey)
        }
    }
    
    // reset the game
    func resetGame() {
        //stop the timer if there is any
        stopTimer()
        stopColorTimer()
        //set the game properties
        model.score = 0
        model.timeRemaining = TapFrenzyModel.totalTime
        model.isGameActive = false
        model.lastTapTime = nil
        model.multiplier = 1
        model.isMultiplying = false
        model.tapButtonColor = .normal
        isGameReset = true
    }
    
    // stop the timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // stop the color timer
    func stopColorTimer() {
        colorTimer?.invalidate()
        colorTimer = nil
    }

    // random button color
    func randomButtonColor() -> TapFrenzyButtonColor {
        TapFrenzyButtonColor.allCases.randomElement()!
    }
    
    // get the game score
    func getScore() -> Int {
        return model.score
    }
    
    // get the game high score
    func getHighScore() -> Int {
        return model.highScore
    }
    
    // get the remaining time
    func getRemainingTime() -> Int {
        return model.timeRemaining
    }
    
    // get is game active
    func isGameActive() -> Bool {
        return model.isGameActive
    }
    
    // get isMultiplying
    func isMultiplying() -> Bool {
        return model.isMultiplying
    }

    // get the tap button color
    func getTapButtonColor() -> TapFrenzyButtonColor {
        return model.tapButtonColor
    }
}
