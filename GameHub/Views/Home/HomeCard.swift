//
//  HomeCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-02.
//

import SwiftUI

struct HomeCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32, weight: .semibold))
                .foregroundColor(.white)

            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [
                    color.opacity(0.8),
                    color.opacity(0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 6)
    }
}

#Preview {
    HomeCard(
        title: "Tap Frenzy",
        subtitle: "Test your speed",
        icon: "hand.tap",
        color: .green
    )
}
