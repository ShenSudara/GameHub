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
    
    private var timer: Timer?
    
    // increase the game score
    func incrementScore() {
        guard model.isGameActive else { return }
        model.score += 1
    }
        
    // start the game
    func startGame() {
        // stop the timer if there any inprogress
        resetGame()
        model.isGameActive = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard self.model.isGameActive else { return }

            if self.model.timeRemaining > 0 {
                self.model.timeRemaining -= 1
            } else {
                self.stopTimer()
                self.model.isGameActive = false
            }
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
    
    // get the remaining time
    func getRemainingTime() -> Int {
        return model.timeRemaining
    }
    
    // get is game active
    func isGameActive() -> Bool {
        return model.isGameActive
    }
}
