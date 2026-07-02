//
//  TapFrenzyModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

// tap frenzy game model
import Foundation

enum TapFrenzyButtonColor: CaseIterable {
    case normal
    case yellow
    case gray
}

struct TapFrenzyModel {
    // game configurations
    static let totalTime: Int = 10
    
    // game properties
    var score: Int = 0
    var timeRemaining: Int = totalTime
    var isGameActive: Bool = false
    var highScore: Int = 0
    var multiplier: Int = 1
    var isMultiplying: Bool = false
    var lastTapTime: Date?
    var tapButtonColor: TapFrenzyButtonColor = .normal
}
