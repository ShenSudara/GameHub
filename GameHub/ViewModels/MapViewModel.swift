//
//  MapViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var gameSessions: [GameSession] = []
    @Published var mapPosition: MapCameraPosition = .automatic
    
    private let gameSessionStore = GameSessionStore.shared
    
    init() {
        loadGameSessions()
    }
    
    // load all game sessions from store
    func loadGameSessions() {
        gameSessions = gameSessionStore.loadSessions()
        updateMapPosition()
    }
    
    // update map position to show all pins with proper bounds
    private func updateMapPosition() {
        guard !gameSessions.isEmpty else {
            mapPosition = .automatic
            return
        }
        
        // calculate bounding box that includes all game session
        let latitudes = gameSessions.map { $0.latitude }
        let longitudes = gameSessions.map { $0.longitude }
        
        // find min and max lat, long
        guard let minLat = latitudes.min(),
              let maxLat = latitudes.max(),
              let minLon = longitudes.min(),
              let maxLon = longitudes.max() else {
            mapPosition = .automatic
            return
        }
        
        // calculate center and span to fit all pins
        let centerLatitude = (minLat + maxLat) / 2
        let centerLongitude = (minLon + maxLon) / 2
        let latDelta = (maxLat - minLat) + 0.1
        let lonDelta = (maxLon - minLon) + 0.1
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        mapPosition = .region(
            MKCoordinateRegion(
                center: centerCoordinate,
                span: MKCoordinateSpan(latitudeDelta: max(latDelta, 0.5), longitudeDelta: max(lonDelta, 0.5))
            )
        )
    }
    
    // get color for game mode
    func modeColor(for mode: GameMode) -> Color {
        switch mode {
        case .tapFrenzy:
            return .green
        case .quickTap:
            return .blue
        case .quizRush:
            return .orange
        }
    }
    
    // get display name for game mode
    func modeName(for mode: GameMode) -> String {
        switch mode {
        case .tapFrenzy:
            return "Tap Frenzy"
        case .quickTap:
            return "Quick Tap"
        case .quizRush:
            return "Quiz Rush"
        }
    }
}
