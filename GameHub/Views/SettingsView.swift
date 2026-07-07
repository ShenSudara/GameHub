//
//  SettingsView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    // view model for settings view
    @StateObject private var viewModel = SettingsViewModel()


    var body: some View {
        Form {
            Section(header: Text("Daily Reminder")) {
                Toggle("Enable daily reminder", isOn: $viewModel.reminderEnabled)
                    .onChange(of: viewModel.reminderEnabled) { _ , newValue in
                        viewModel.onReminderToggleChanged(newValue)
                    }

                DatePicker("Reminder time", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
                    .onChange(of: viewModel.reminderTime) { _ , newDate in
                        viewModel.reminderTimeChanged(newDate)
                    }

                if viewModel.notificationsDenied {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(
                            "Notifications are disabled for this app. Please enable them in Settings."
                        )
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        Button("Open Settings") {
                            viewModel.openSettings()
                        }
                    }
                }
                
                Button {
                    viewModel.clearCache()
                } label: {
                    Label("Clear Cache", systemImage: "trash.fill")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .red.opacity(0.3), radius: 8, y: 4)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            viewModel.refresh()
        }
    }
}

#Preview {
    SettingsView()
}
