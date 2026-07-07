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
    
    var body: some View {
        let barHeight = CGFloat(summary.highScore) / CGFloat(max(summary.totalScore, 1)) * 110
        let visibleBarHeight = max(barHeight, summary.sessionCount > 0 ? 24 : 12)
        
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline.bold())
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
        .frame(maxWidth: .infinity, maxHeight: 220 ,alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    ModeChartCard(
        summary: GameModeSummary(mode: .quickTap, sessionCount: 10,totalScore: 280, highScore: 100),
        title: "Classic Mode",
        tint: .blue
    )
}
