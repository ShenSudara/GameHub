//
//  GameModeSummary.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//


// summary model for a specific game mode
struct GameModeSummary: Identifiable {
    let mode: GameMode
    var id: String {
        mode.rawValue
    }
    let sessionCount: Int
    let totalScore: Int
    let highScore: Int
}
