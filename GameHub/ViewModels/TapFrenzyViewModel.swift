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
        
        model.score += self.model.multiplier
        model.lastTapTime = currentTime
    }
        
    // start the game
    func startGame() {
        // stop the timer if there any inprogress
        resetGame()
        isGameReset = false
        model.isGameActive = true

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
                self.model.isGameActive = false
                
                // after game end reset multiplier
                self.model.multiplier = 1
                self.model.isMultiplying = false
                self.model.lastTapTime = nil
                
                // update the high score
                updateHighScore()
            }
        }
    }
    
    // high score update logic
    func updateHighScore() {
        if model.score > model.highScore{
            model.highScore = model.score
        }
    }
    
    // reset the game
    func resetGame() {
        //stop the timer if there is any
        stopTimer()
        //set the game properties
        model.score = 0
        model.timeRemaining = TapFrenzyModel.totalTime
        model.isGameActive = false
        model.lastTapTime = nil
        model.multiplier = 1
        model.isMultiplying = false
        isGameReset = true
    }
    
    // stop the timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
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
}
