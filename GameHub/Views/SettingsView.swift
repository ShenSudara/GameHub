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
