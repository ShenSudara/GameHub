//
//  ModeChartCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//


import SwiftUI

struct ModeChartCard: View {
    let summary: GameModeSummary
    let title: String
    let tint: Color
    let maxHighScore: Int
    
    var body: some View {
        let barHeight = CGFloat(summary.highScore) / CGFloat(max(maxHighScore, 1)) * 110
        let visibleBarHeight = max(barHeight, summary.sessionCount > 0 ? 24 : 12)
        
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("High Score")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .bottom, spacing: 10) {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(tint.gradient)
                        .frame(width: 28, height: visibleBarHeight)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(summary.highScore)")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        Text("\(summary.sessionCount) rounds")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.secondary)
                    }
                }
                
                Text("Total \(summary.totalScore) pts")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(tint)
            }
        }
        .padding()
        .frame(width: 190, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    ModeChartCard(
        summary: GameModeSummary(mode: .quickTap, sessionCount: 10,totalScore: 280, highScore: 820),
        title: "Classic Mode",
        tint: .blue,
        maxHighScore: 1000
    )
}
