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
            .scaleEffect(isActive ? 1.08 : 1.0)
            .frame(height: 55)
            .contentShape(RoundedRectangle(cornerRadius: 14))
            .animation(
                .spring(response: 0.35, dampingFraction: 0.7),
                value: isActive
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    action()
                }
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
}
