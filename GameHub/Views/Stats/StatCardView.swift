//
//  StatCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//


import SwiftUI

struct StatCard: View {
    
    let title: String
    let value: String
    let systemImage: String
    let tint: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(tint)
                Spacer()
            }
            
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 110)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    StatCard(
        title: "Completed",
        value: "24",
        systemImage: "checkmark.circle.fill",
        tint: .green
    )
}
