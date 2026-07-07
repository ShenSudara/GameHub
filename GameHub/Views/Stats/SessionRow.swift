//
//  SessionRow.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//


import SwiftUI

struct SessionRow: View {
    let modeName: String
    let score: Int
    let dateText: String
    let timeText: String
    let tint: Color
    let isHighScore: Bool

    // parse game session
    init(_ session: GameSession) {
        self.score = session.score

        // derive mode name and tint
        switch session.mode {
        case .tapFrenzy:
            self.modeName = "Tap Frenzy"
            self.tint = .green
        case .quickTap:
            self.modeName = "Quick Tap"
            self.tint = .blue
        case .quizRush:
            self.modeName = "Quiz Rush"
            self.tint = .orange
        }

        // date/time formatting
        let date = session.timestamp
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        self.dateText = df.string(from: date)

        let tf = DateFormatter()
        tf.dateStyle = .none
        tf.timeStyle = .short
        self.timeText = tf.string(from: date)

        // compute high score from the scores session
        let globalHigh = GameSessionStore.shared.loadSessions().filter { $0.mode == session.mode }.map(\.score).max() ?? 0
        self.isHighScore = session.score == globalHigh && session.score > 0
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Circle()
                .fill(tint.opacity(0.15))
                .frame(width: 44, height: 44)
                .overlay(
                    Text("\(score)")
                        .font(.caption.bold())
                        .foregroundColor(tint)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(modeName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    if isHighScore {
                        Text("High Score")
                            .font(.caption2.bold())
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(tint.opacity(0.12))
                            .foregroundColor(tint)
                            .clipShape(Capsule())
                    }
                }
                
                Text("\(dateText) • \(timeText)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(score)")
                .font(.title3.bold())
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    SessionRow(GameSession(
        id: UUID(),
        mode: .quickTap,
        score: 10,
        timestamp: .now,
        latitude: 1.0,
        longitude: 1.0
    ))
}
