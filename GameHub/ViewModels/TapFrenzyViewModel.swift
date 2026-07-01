//
//  TapFrenzyViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

import Foundation
import Combine

// view model class for tap frenzy
@MainActor
final class TapFrenzyViewModel: ObservableObject {
    @Published private var model = TapFrenzyModel()
    
    // increase the game score
    func incrementScore() {
        model.score += 1
    }
    
    // get the game score
    func getScore() -> Int {
        return model.score
    }
}
