//
//  HomeView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-02.
//

import SwiftUI

// home screen for games
struct HomeView: View {
    var body: some View {
        VStack(spacing: 40) {
            // header
            VStack(spacing: 8) {
                Text("GameHub")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
                    .tracking(2)
                
                Text("Pick Your Game")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 20)

            // games container
            VStack(spacing: 20) {
                // tap frenzy game card
                NavigationLink(destination: TapFrenzyView()) {
                    HomeCard(
                        title: "Tap Frenzy",
                        subtitle: "Test your speed",
                        icon: "hand.tap",
                        color: .green
                    )
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
