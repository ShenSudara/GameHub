//
//  NotificationPermissionView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI

struct NotificationPermissionView: View {
    let onClick: () -> Void

    var body: some View {
        Spacer()
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                Image(systemName: "bell.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.orange)
                Text("Enable Notifications")
                    .font(.headline)
                Text("Allow GameHub to send you a daily reminder to play.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                Button {
                    onClick()
                } label: {
                    Text("Allow Notifications")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
                .tint(.orange)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(radius: 4)
        }
        .padding()
        Spacer()
    }
}

#Preview {
    NotificationPermissionView(onClick: { print("notif click") })
}
