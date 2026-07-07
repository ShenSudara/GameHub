//
//  StatsView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel = StatsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // over all performance
                VStack(alignment: .leading, spacing: 14) {
                    Text("Statistics")
                        .font(.title.bold())
                        .foregroundColor(.green)
                    
                    Text("Overall Performance")
                        .font(.title3.bold())
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 12) {
                        StatCard(title: "Sessions", value: "\(viewModel.totalSessions)", systemImage: "chart.bar.fill", tint: .green)
                        StatCard(title: "High Score", value: "\(viewModel.highScore)", systemImage: "star.fill", tint: .orange)
                    }
                }
                
                // charts for game mode
                VStack(alignment: .leading, spacing: 12) {
                    Text("Mode Overview")
                        .font(.title3.bold())
                        .foregroundColor(.primary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.modeSummaries) { summary in
                                ModeChartCard(
                                    summary: summary,
                                    title: viewModel.displayName(for: summary.mode),
                                    tint: viewModel.color(for: summary.mode),
                                    maxHighScore: summary.highScore
                                )
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                // session list view
                VStack(alignment: .leading, spacing: 12) {
                    Text("Session History")
                        .font(.title3.bold())
                        .foregroundColor(.primary)
                    
                    if viewModel.sessions.isEmpty {
                        EmptySessionView()
                    } else {
                        VStack(spacing: 12) {
                            ForEach(viewModel.sessions) { session in
                                SessionRow(session)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            viewModel.loadSessions()
        }
    }
}

#Preview {
    StatsView()
}
