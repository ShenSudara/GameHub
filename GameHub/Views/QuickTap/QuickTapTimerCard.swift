//
//  QuickTapTimerCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-03.
//

import SwiftUI

import SwiftUI

struct QuickTapTimerCard: View {
    
    let time: Int
    private var timerColor: Color {
        if time <= 15 { return .green }
        else if time <= 30 { return .blue }
        else if time <= 45 { return .orange }
        else { return .red }
    }
    private var timerScale: CGFloat {
        if time <= 30 { return 1.0 }
        else { return 1.15 }
    }
    
    var body: some View {
        VStack(spacing: 6) {
            
            Text("TIME")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.7))
            
            Text("\(time)s")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(timerColor)
                .scaleEffect(timerScale)
                .animation(.easeInOut(duration: 0.2), value: time)
                .contentTransition(.numericText())
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(timerColor.opacity(0.2), lineWidth: 1)
                )
        )
        .shadow(color: timerColor.opacity(0.2),
                radius: 10, x: 0, y: 5)
    }
}

#Preview {
    QuickTapTimerCard(time: 46)
}

