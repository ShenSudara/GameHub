//
//  StatsView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel = StatsViewModel()
    private let modes : [GameMode] = [.tapFrenzy, .quickTap, .quizRush]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // over all performance
                VStack(alignment: .leading, spacing: 14) {                    
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
                    Text("Insights")
                        .font(.title3.bold())
                        .foregroundColor(.primary)
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            ModeChartCard(
                                summary: viewModel.modeSummaries[0],
                                title: viewModel.displayName(for: viewModel.modeSummaries[0].mode),
                                tint: viewModel.color(for: viewModel.modeSummaries[0].mode)
                            )
                            
                            ModeChartCard(
                                summary: viewModel.modeSummaries[1],
                                title: viewModel.displayName(for: viewModel.modeSummaries[1].mode),
                                tint: viewModel.color(for: viewModel.modeSummaries[1].mode)
                            )
                        }
                        ModeChartCard(
                            summary: viewModel.modeSummaries[2],
                            title: viewModel.displayName(for: viewModel.modeSummaries[2].mode),
                            tint: viewModel.color(for: viewModel.modeSummaries[2].mode)
                        )
                    }
                }
                
                // charts for game mode
                VStack(alignment: .leading, spacing: 12) {
                    Text("Daily Trends")
                        .font(.title3.bold())
                        .foregroundColor(.primary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(modes, id: \.self) { mode in
                                ModeSummaryCard(mode: mode, sessions: viewModel.sessions.filter { $0.mode == mode })
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

