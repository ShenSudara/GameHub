//
//  MapView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.mapPosition) {
                ForEach(viewModel.gameSessions) { session in
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: session.latitude, longitude: session.longitude)) {
                        VStack(spacing: 0) {
                            // pin marker circle
                            Circle()
                                .fill(viewModel.modeColor(for: session.mode))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .overlay(
                                    Text("\(session.score)")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                )
                            
                            // callout with mode and score
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.modeName(for: session.mode))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                
                                HStack {
                                    Text("Score:")
                                        .font(.caption2)
                                    Text("\(session.score)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                                
                                HStack(spacing: 2) {
                                    Image(systemName: "location.fill")
                                        .font(.caption2)
                                    Text(String(format: "%.2f, %.2f", session.latitude, session.longitude))
                                        .font(.caption2)
                                }
                            }
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        }
                    }
                }
            }
            .mapStyle(.standard)
            
            // header with session count
            VStack {
                HStack {
                    Text("Game Sessions")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("\(viewModel.gameSessions.count)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding()
                
                Spacer()
            }
            .padding(.vertical)
        }
        .ignoresSafeArea(edges: .all)
        .onAppear {
            viewModel.loadGameSessions()
        }
    }
}

#Preview {
    MapView()
}
