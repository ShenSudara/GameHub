//
//  QuickTapViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-03.
//

import Foundation
import Combine
import SwiftUI

// view model class for quick tap
final class QuickTapViewModel : ObservableObject{
    @Published private var model: QuickTapModel = QuickTapModel()
    @Published var isGameReset: Bool = true // show and hide game overview
    // timers
    private var timer: Timer?
    private var cellTimer: Timer?

    private let highScoreKey = "QuickTapHighScore"

    init() {
        model.highScore = UserDefaults.standard.integer(forKey: highScoreKey)
    }
    
    // start the game
    func startGame() {
        reset()
        isGameReset = false
        model.isGameActive = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard self.model.isGameActive else { return }
            self.model.timeElapsed += 1
            
            // update the current level
            self.updateCurrentLevel()
            
            // if timeelapsed is more than 60 end the game
            if(self.model.timeElapsed >= QuickTapModel.totalTime){
                self.model.isGameActive = false
                self.stopTimer()
                self.stopCellTimer()
                self.updateHighScore()
                GameSessionStore.shared.recordRoundScore(mode: .quickTap, score: self.model.score)
            }
        }
        
        runCellLoop()
    }
    
    // update the current level info
    func updateCurrentLevel(){
        guard let level = QuickTapModel.levels.first(where: { $0.duration.contains(model.timeElapsed) }) else { return }
        model.gridSize = level.gridSize
        model.color = level.color
    }
    
    // run cell timer for highlight grid cells
    func runCellLoop(){
        cellTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard self.model.isGameActive else { return }
            
            // highlight cells
            guard let level = QuickTapModel.levels.first(where: { $0.duration.contains(self.model.timeElapsed) }) else { return }
            let totalCells = self.model.gridSize.width * self.model.gridSize.height
            self.model.activeCells.removeAll()
            
            // generate new active cells
            var newSet = Set<Int>()
            while newSet.count < level.litCount {
                newSet.insert(Int.random(in: 0..<Int(totalCells)))
            }
            self.model.activeCells = newSet
            
            // remove active cells after duration
            DispatchQueue.main.asyncAfter(deadline: .now() + level.litDuration) {
                self.model.activeCells.removeAll()
            }
        }
    }
    
    // logic when tap cells
    func tapCell(_ index: Int){
        if model.activeCells.contains(index) {
            model.score += 1
            model.activeCells.remove(index)
        } else {
            model.score = max(0, model.score - 1)
        }
    }
    
    // reset the game
    func reset(){
        self.model.timeElapsed = 0
        self.model.score = 0
        self.model.isGameActive = false
        
        self.model.gridSize = CGSize(width: 1, height: 3)
        self.model.activeCells.removeAll()
        self.model.color = .green
        self.isGameReset = true
        
        stopTimer()
        stopCellTimer()
    }

    // update the high score
    func updateHighScore(){
        if model.score > model.highScore {
            model.highScore = model.score
            UserDefaults.standard.set(model.highScore, forKey: highScoreKey)
        }
    }
    
    // stop primary timer
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    // stop cell timer
    func stopCellTimer(){
        cellTimer?.invalidate()
        cellTimer = nil
    }
    
    // get primary time
    func getTimeElapsed() -> Double {
        return model.timeElapsed
    }
    
    // get game is active
    func isGameActive() -> Bool {
        return model.isGameActive
    }
    
    // get score
    func getScore() -> Int{
        return model.score
    }

    // get high score
    func getHighScore() -> Int {
        return model.highScore
    }
    
    // get active cells
    func getActiveCells() -> Set<Int> {
        return model.activeCells
    }
    
    // get grid size
    func getGridSize() -> CGSize {
        return model.gridSize
    }
    
    // get color
    func getColor() -> Color {
        return model.color
    }
}
