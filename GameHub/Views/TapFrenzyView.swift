//
//  TapFrenzyView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

import SwiftUI

// game main view
struct TapFrenzyView: View {
    // view model for tap frenzy
    @StateObject var tapFrenzyVM: TapFrenzyViewModel = TapFrenzyViewModel()
    
    var body: some View {
        VStack(spacing: 30){
            // score card
            HStack {
                TimerCard(time: tapFrenzyVM.getRemainingTime())
                ScoreCard(title: "Score", value: tapFrenzyVM.getScore(), isMultiplying: tapFrenzyVM.isMultiplying())
            }.padding(.horizontal)
            
            // inner container
            VStack{
                // if game is active show tap button otherwise show game overview
                if(tapFrenzyVM.isGameActive() || tapFrenzyVM.isGameReset){
                    TapButton(action: {
                        tapFrenzyVM.incrementScore()
                    })
                    .transition(.scale.combined(with: .opacity))
                }else{
                    GameOverView(
                        score: tapFrenzyVM.getScore(),
                        highScore: tapFrenzyVM.getHighScore(),
                        onRestart: {
                            tapFrenzyVM.resetGame()
                        }
                    )
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // start button
            if !tapFrenzyVM.isGameActive() && tapFrenzyVM.getRemainingTime() == TapFrenzyModel.totalTime {
                Button(action: {
                    tapFrenzyVM.startGame()
                }) {
                    Text("Start Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .padding(.vertical)
        .animation(.easeInOut(duration: 0.3), value: tapFrenzyVM.isGameActive())
    }
}

#Preview {
    TapFrenzyView()
}
