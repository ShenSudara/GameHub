//
//  EmptySessionView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//


import SwiftUI

struct EmptySessionView: View {
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "chart.bar.xaxis")
                .font(.system(size: 28))
                .foregroundColor(.green)
            
            Text("No sessions yet")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Play a round to see your stats here.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    EmptySessionView()
}