//
//  GameSessionStore.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import Foundation
import CoreLocation

// class for handle game sessions
final class GameSessionStore {
    static let shared = GameSessionStore()

    private let storageKey = "GameSession"
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let defaults: UserDefaults

    // initialize the properties
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
        self.encoder.dateEncodingStrategy = .iso8601
        self.decoder.dateDecodingStrategy = .iso8601
    }

    // record a game round score
    func recordRoundScore(mode: GameMode, score: Int) {
        let coordinate = LocationPermissionManager.shared.location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let session = GameSession(
            id: UUID(),
            mode: mode,
            score: score,
            timestamp: Date(),
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )

        var sessions = loadSessions()
        sessions.append(session)
        save(sessions)
    }

    // get the all game sessions information
    func loadSessions() -> [GameSession] {
        guard let data = defaults.data(forKey: storageKey) else { return [] }
        return (try? decoder.decode([GameSession].self, from: data)) ?? []
    }
    
    // clear cache
    func clearCache() {
        defaults.removeObject(forKey: storageKey)
    }
    
    // save the game session information
    private func save(_ sessions: [GameSession]) {
        guard let data = try? encoder.encode(sessions) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
