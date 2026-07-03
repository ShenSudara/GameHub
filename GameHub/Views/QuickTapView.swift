//
//  QuickTapView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-02.
//

import SwiftUI

struct QuickTapView: View {
    var body: some View {
        VStack(spacing: 30){
            // for score card
            HStack{
                QuickTapTimerCard(time: 46)
                QuickTapScoreCard(title: "SCORE", value: 20)
            }.padding(.horizontal)
            
            // inner container
            VStack{
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // start button
            Button(action: {
                print("button clicked")
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
        .padding(.vertical)
    }
}

#Preview {
    QuickTapView()
}
