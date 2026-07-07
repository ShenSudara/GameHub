//
//  SplashView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-06.
//

import SwiftUI

struct SplashView: View {
    @State private var animate = true

    var body: some View {
        ZStack {
            // background gradient (green themed)
            LinearGradient(
                colors: [.orange, .blue, .green],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            GeometryReader { geo in
                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.7)
                    .blur(radius: 40)
                    .offset(x: animate ? -30 : -100, y: animate ? -80 : -40)
                    .rotationEffect(.degrees(animate ? 0 : 45))

                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white.opacity(0.04))
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.18)
                    .blur(radius: 30)
                    .offset(x: animate ? 80 : 140, y: animate ? 100 : 140)
                    .rotationEffect(.degrees(animate ? 8 : -6))
            }

            // logo
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [Color.white.opacity(0.12), Color.white.opacity(0.04)], startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 6)

                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                        .foregroundStyle(LinearGradient(colors: [Color.green.opacity(0.9), Color.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .rotationEffect(.degrees(animate ? 6 : -6))
                }

                Text("Game Hub")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 4)

                Text("Welcome to your gaming hub\nloading content")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                // Progress indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
                    .padding(.top, 6)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 80)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    animate.toggle()
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
