//
//  QuickTapModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-03.
//

import Foundation
import SwiftUI

// model class for game level
struct QuickTapLevel {
    let duration: ClosedRange<Double>
    let gridSize: CGSize
    let litCount: Int
    let litDuration: Double
    let color: Color
}

// game model class for quick tap
struct QuickTapModel {
    // game configurations
    static let totalTime: Double = 60
    // game levels
    static let levels: [QuickTapLevel] = [
        QuickTapLevel(duration: 0...15, gridSize: CGSize(width: 1, height: 3), litCount: 1, litDuration: 1.5, color: .green),
        QuickTapLevel(duration: 15...30, gridSize: CGSize(width: 2, height: 2), litCount: 1, litDuration: 1.2, color: .blue),
        QuickTapLevel(duration: 30...45, gridSize: CGSize(width: 2, height: 3), litCount: 1, litDuration: 1.0, color: .orange),
        QuickTapLevel(duration: 45...60, gridSize: CGSize(width: 3, height: 3), litCount: 2, litDuration: 0.8, color: .red)
    ]
    
    // game properties
    var timeElapsed: Double = 0
    var score: Int = 0
    var activeCells: Set<Int> = []
    var gridSize: CGSize =  CGSize(width: 1, height: 3)
    var color: Color = .green
    var isGameActive: Bool = false
    var highScore: Int = 0
}
