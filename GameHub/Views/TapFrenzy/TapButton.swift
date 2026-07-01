//
//  TapButton.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

import SwiftUI

struct TapButton: View {
    @State private var isPressed: Bool = false
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            // outer boundary
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    RadialGradient(
                        colors: [
                            Color.green.opacity(0.6),
                            Color.green.opacity(0.2),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 120
                    )
                )
                .frame(width: 220, height: 220)
                .blur(radius: 10)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.15), value: isPressed)
            
            // inner button
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.green.opacity(0.9),
                            Color.green.opacity(0.4),
                            Color.green.opacity(0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 160, height: 160)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 6)
                .scaleEffect(isPressed ? 0.92 : 1.0)
                .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isPressed)
                .overlay(
                    Text("Tap Me")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(2)
                        .scaleEffect(isPressed ? 0.9 : 1.0)
                        .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isPressed)
                )
        }.onTapGesture{
            isPressed = true
            
            // execute the action
            action()
            
            // reset the animation state
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }
    }
}

#Preview {
    TapButton(action:{
        print("Tap button is clicked")
    })
}
