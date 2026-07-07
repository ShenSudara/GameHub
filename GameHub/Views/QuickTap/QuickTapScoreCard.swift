//
//  QuickTapScoreCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-03.
//


import SwiftUI

import SwiftUI

struct QuickTapScoreCard: View {
    let title: String
    let value: Int

    var body: some View {
        VStack(spacing: 6) {
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)

            Text("\(value)")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .contentTransition(.numericText())
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.gray.opacity(0.2), lineWidth: 1)))
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
    }
}

#Preview{
    QuickTapScoreCard(title: "Test Title", value: 30)
}
