//
//  TimerCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-02.
//

import SwiftUI

struct TimerCard: View {
    
    let time: Int
    
    private var isLowTime: Bool {
        time <= 3
    }
    
    var body: some View {
        VStack(spacing: 6) {
            
            Text("TIME")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.7))
            
            Text("\(time)s")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(isLowTime ? .red : .green)
                .scaleEffect(isLowTime ? 1.15 : 1.0)
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
                        .stroke(
                            isLowTime ? Color.red.opacity(0.2) : Color.gray.opacity(0.15),
                            lineWidth: 1
                        )
                )
        )
        .shadow(color: isLowTime ? .red.opacity(0.3) : .black.opacity(0.08),
                radius: 10, x: 0, y: 5)
    }
}

#Preview {
    TimerCard(time: 4)
}
