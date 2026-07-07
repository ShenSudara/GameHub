//
//  ModeSummaryCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI
import Charts

struct ModeSummaryCard: View {
    let mode: GameMode
    let sessions: [GameSession]
    
    // get session counts grouped by weekday
    private var weekdayCounts: [(label: String, count: Int)] {
        let calendar = Calendar.current
        let symbols = calendar.shortWeekdaySymbols
        var counts = Array(repeating: 0, count: 7)
        for session in sessions {
            let weekday = calendar.component(.weekday, from: session.timestamp)
            counts[weekday - 1] += 1
        }
        return symbols.enumerated().map { index, label in
            (label: label, count: counts[index])
        }
    }
    
    // get title
    private var title: String{
        switch mode {
        case .tapFrenzy:
            return "Tap Frenzy"
        case .quickTap:
            return "Quick Tap"
        case .quizRush:
            return "Quiz Rush"
        }
    }
    
    // get color
    private var color: Color{
        switch mode {
        case .tapFrenzy:
            return .green
        case .quickTap:
            return .blue
        case .quizRush:
            return .orange
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(title) by Day")
                .font(.headline)
                .foregroundColor(.primary)

            Chart {
                ForEach(weekdayCounts, id: \.label) { item in
                    BarMark(
                        x: .value("Day", item.label),
                        y: .value("Sessions", item.count)
                    )
                    .annotation(position: .top) {
                        if item.count > 0 {
                            Text("\(item.count)")
                                .font(.caption2.bold())
                                .foregroundColor(.primary)
                        }
                    }
                    .foregroundStyle(color)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisTick()
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 160)
        }
        .frame(width: 280)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    ModeSummaryCard(
        mode: .tapFrenzy,
        sessions: GameSessionStore.shared.loadSessions()
    )
}
