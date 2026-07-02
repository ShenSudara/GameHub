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
    let buttonColor: TapFrenzyButtonColor

    private var outerColors: [Color] {
        switch buttonColor {
        case .yellow:
            return [Color.yellow.opacity(0.7), Color.yellow.opacity(0.25), Color.clear]
        case .gray:
            return [Color.gray.opacity(0.55), Color.gray.opacity(0.18), Color.clear]
        case .normal:
            return [Color.green.opacity(0.6), Color.green.opacity(0.2), Color.clear]
        }
    }

    private var innerColors: [Color] {
        switch buttonColor {
        case .yellow:
            return [Color.yellow.opacity(0.95), Color.yellow.opacity(0.55), Color.yellow.opacity(0.2)]
        case .gray:
            return [Color.gray.opacity(0.9), Color.gray.opacity(0.55), Color.gray.opacity(0.25)]
        case .normal:
            return [Color.green.opacity(0.9), Color.green.opacity(0.4), Color.green.opacity(0.1)]
        }
    }

    private var textColor: Color {
        switch buttonColor {
        case .yellow:
            return .black
        case .gray, .normal:
            return .white
        }
    }
    
    var body: some View {
        ZStack {
            // outer boundary
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    RadialGradient(
                        colors: outerColors,
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
                        colors: innerColors,
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
                        .foregroundColor(textColor)
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
    }, buttonColor: TapFrenzyButtonColor.yellow)
}
