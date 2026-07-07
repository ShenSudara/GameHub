//
//  GameSession.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import Foundation

// game session model
struct GameSession: Codable, Identifiable {
    let id: UUID
    let mode: GameMode
    let score: Int
    let timestamp: Date
    let latitude: Double
    let longitude: Double
}
