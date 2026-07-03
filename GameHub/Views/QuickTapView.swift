//
//  QuickTapView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-02.
//

import SwiftUI

struct QuickTapView: View {
    // view model class for quick tap
    @StateObject var quickTapVM: QuickTapViewModel = QuickTapViewModel()
    
    var body: some View {
        VStack(spacing: 30){
            // for score card
            HStack{
                QuickTapTimerCard(time: Int(quickTapVM.getTimeElapsed()))
                QuickTapScoreCard(title: "SCORE", value: quickTapVM.getScore())
            }.padding(.horizontal)
            
            // inner container
            VStack{
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 10),
                        count: Int(quickTapVM.getGridSize().height)
                    ),
                    spacing: 10
                ) {
                    ForEach(0..<(Int(quickTapVM.getGridSize().width) * Int(quickTapVM.getGridSize().height)), id: \.self) { index in
                        QuickTapTapCard(
                            isActive: quickTapVM.getActiveCells().contains(index),
                            color: quickTapVM.getColor()
                        ) {
                            quickTapVM.tapCell(index)
                        }
                    }
                }
                .padding(14)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            .animation(.easeInOut(duration: 1.2), value: quickTapVM.isGameActive())
            
            
            // start button
            if(!quickTapVM.isGameActive() && quickTapVM.getTimeElapsed() == 0){
                Button(action: {
                    quickTapVM.startGame()
                }) {
                    Text("Start Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    QuickTapView()
}
