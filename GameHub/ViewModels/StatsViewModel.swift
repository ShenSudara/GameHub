//
//  StatsViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI
import Foundation
import Combine

// view model for game stats screen
final class StatsViewModel: ObservableObject {
    @Published private(set) var sessions: [GameSession] = []
    
    private let gameSessionStore = GameSessionStore.shared
    private let gameModes: [GameMode] = [.tapFrenzy, .quickTap, .quizRush]
    
    init() {
        loadSessions()
    }
    
    // load all sessions from the shared store
    func loadSessions() {
        sessions = gameSessionStore.loadSessions().sorted { $0.timestamp > $1.timestamp }
    }
    
    // get the total session count
    var totalSessions: Int {
        sessions.count
    }
    
    // get the high score
    var highScore: Int {
        sessions.map(\.score).max() ?? 0
    }
    
    // get the mode summaries
    var modeSummaries: [GameModeSummary] {
        gameModes.map { mode in
            let modeSessions = sessions.filter { $0.mode == mode }
            let totalScore = modeSessions.reduce(0) { $0 + $1.score }
            let bestScore = modeSessions.map(\.score).max() ?? 0
            
            return GameModeSummary(
                mode: mode,
                sessionCount: modeSessions.count,
                totalScore: totalScore,
                highScore: bestScore
            )
        }
    }
    
    // get the display name
    func displayName(for mode: GameMode) -> String {
        switch mode {
        case .tapFrenzy:
            return "Tap Frenzy"
        case .quickTap:
            return "Quick Tap"
        case .quizRush:
            return "Quiz Rush"
        }
    }
    
    // get the display color
    func color(for mode: GameMode) -> Color {
        switch mode {
        case .tapFrenzy:
            return .green
        case .quickTap:
            return .blue
        case .quizRush:
            return .orange
        }
    }
    
    // date formatter : String
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    // time formatter : string
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
