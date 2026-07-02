//
//  GameOverView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-02.
//

import SwiftUI

struct GameOverView: View {
    
    let score: Int
    let highScore: Int
    let onRestart: () -> Void
    
    private var isNewHighScore: Bool {
        score >= highScore && score > 0
    }
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("GAME OVER")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
                    .tracking(2)
                
                VStack(spacing: 12) {
                    
                    Text("FINAL SCORE")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("\(score)")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                        .contentTransition(.numericText())
                    
                    Text("HIGH SCORE: \(highScore)")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.7))
                    
                    if isNewHighScore {
                        Text("NEW HIGH SCORE!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .padding(.top, 6)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .green.opacity(0.15), radius: 12, x: 0, y: 6)
                )
                .padding(.horizontal)
                
                Button(action: {
                    onRestart()
                }) {
                    Text("Play Again")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color.green.opacity(0.9),
                                    Color.green
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                        .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 6)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameOverView(score: 50, highScore: 30, onRestart: {
        print("Restart button is clicked")
    })
}
