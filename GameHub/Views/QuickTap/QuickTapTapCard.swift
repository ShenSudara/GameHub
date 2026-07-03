//
//  QuickTapTapCard.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-03.
//

import SwiftUI

struct QuickTapTapCard: View {
    
    let isActive: Bool
    let color: Color
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
            .fill(isActive ? color.opacity(0.9) : Color.gray.opacity(0.2))
            .overlay {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(
                        isActive ? color.opacity(0.6) : Color.clear,
                        lineWidth: 2
                    )
            }
            .shadow(
                color: isActive ? color.opacity(0.25) : .clear,
                radius: 10,
                x: 0,
                y: 6
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .frame(height: 100)
            .contentShape(RoundedRectangle(cornerRadius: 14))
            .animation(
                .spring(response: 0.35, dampingFraction: 0.7),
                value: isPressed
            )
            .animation(
                .spring(response: 0.35, dampingFraction: 0.7),
                value: isPressed
            )
            .onTapGesture {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    isPressed = false
                }
                action()
            }
    }
}

#Preview {
    VStack(spacing: 20) {
        QuickTapTapCard(
            isActive: true,
            color: .green,
            action: {
                print("Tapped")
            }
        )

        QuickTapTapCard(
            isActive: false,
            color: .green,
            action: {
                print("Tapped")
            }
        )
    }
    .padding()
    .padding()
}
