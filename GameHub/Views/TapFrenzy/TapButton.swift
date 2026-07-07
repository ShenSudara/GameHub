//
//  TapButton.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

import SwiftUI

struct TapButton: View {
    let action: () -> Void
    let buttonColor: TapFrenzyButtonColor
    
    @State private var isPressed: Bool = false
    
    // properties for animation
    @State private var position: CGPoint = .zero
    @State private var velocity: CGVector = .zero
    @State private var containerSize: CGSize = .zero
    @State private var movementTimer: Timer?
    
    private let outerSize: CGFloat = 220
    private var halfSize: CGFloat { outerSize / 2 }
    
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
        GeometryReader { proxy in
            ZStack {
                // move button using position. so it can travel within parent
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
                        .frame(width: outerSize, height: outerSize)
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
                }
                .position(x: position.x, y: position.y)
                .onTapGesture {
                    isPressed = true
                    action()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressed = false
                    }
                }
            }.onAppear {
                containerSize = proxy.size
                
                // ensure container is large enough
                if containerSize.width < outerSize { containerSize.width = outerSize }
                if containerSize.height < outerSize { containerSize.height = outerSize }
                
                if position == .zero {
                    position = randomStart(in: containerSize)
                    velocity = randomVelocity()
                }
                startMovementTimer()
            }
            .onChange(of: proxy.size) { oldSize, newSize in
                containerSize = newSize
                if containerSize.width < outerSize { containerSize.width = outerSize }
                if containerSize.height < outerSize { containerSize.height = outerSize}
                clampPosition()
            }
            .onDisappear {
                stopMovementTimer()
            }
        }
    }

    // start the movement timer
    private func startMovementTimer() {
        stopMovementTimer()
        movementTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            DispatchQueue.main.async {
                updatePosition(dt: 0.02)
            }
        }
    }

    // stop the movement timer
    private func stopMovementTimer() {
        movementTimer?.invalidate()
        movementTimer = nil
    }

    // update the next position
    private func updatePosition(dt: CGFloat) {
        var next = CGPoint(x: position.x + velocity.dx * dt, y: position.y + velocity.dy * dt)
        let minX = halfSize
        let maxX = containerSize.width - halfSize
        let minY = halfSize
        let maxY = containerSize.height - halfSize

        var hitBoundary = false

        if next.x < minX {
            next.x = minX
            hitBoundary = true
        } else if next.x > maxX {
            next.x = maxX
            hitBoundary = true
        }

        if next.y < minY {
            next.y = minY
            hitBoundary = true
        } else if next.y > maxY {
            next.y = maxY
            hitBoundary = true
        }

        position = next

        if hitBoundary {
            velocity = randomVelocityTowardCenter()
        }
    }

    // set the position
    private func clampPosition() {
        let minX = halfSize
        let maxX = containerSize.width - halfSize
        let minY = halfSize
        let maxY = containerSize.height - halfSize

        var p = position
        if p.x < minX { p.x = minX }
        if p.x > maxX { p.x = maxX }
        if p.y < minY { p.y = minY }
        if p.y > maxY { p.y = maxY }
        position = p
    }

    // random position for start
    private func randomStart(in size: CGSize) -> CGPoint {
        let minX = halfSize
        let maxX = size.width - halfSize
        let minY = halfSize
        let maxY = size.height - halfSize
        let x = CGFloat.random(in: minX...maxX)
        let y = CGFloat.random(in: minY...maxY)
        return CGPoint(x: x, y: y)
    }

    
    // generate random velocity and angle
    private func randomVelocity() -> CGVector {
        let angle = Double.random(in: 0..<(2 * Double.pi))
        let speed = Double.random(in: 60...140)
        return CGVector(dx: CGFloat(cos(angle) * speed), dy: CGFloat(sin(angle) * speed))
    }

    // generate random velocity if hit boundary goes through center
    private func randomVelocityTowardCenter() -> CGVector {
        let center = CGPoint(x: containerSize.width / 2, y: containerSize.height / 2)
        let dx = center.x - position.x
        let dy = center.y - position.y
        let baseAngle = atan2(Double(dy), Double(dx))
        let jitter = Double.random(in: -Double.pi/3...Double.pi/3)
        let angle = baseAngle + jitter
        let speed = Double.random(in: 60...140)
        return CGVector(dx: CGFloat(cos(angle) * speed), dy: CGFloat(sin(angle) * speed))
    }
}

#Preview {
    TapButton(action:{
        print("Tap button is clicked")
    }, buttonColor: TapFrenzyButtonColor.yellow)
}
