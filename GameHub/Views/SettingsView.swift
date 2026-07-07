//
//  SettingsView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    // properties for settings view
    @State private var reminderEnabled: Bool = NotificationService.shared.isEnabledInSettings
    @State private var reminderTime: Date = NotificationService.shared.savedTime() ?? Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
    @State private var authStatus: UNAuthorizationStatus? = NotificationService.shared.authorizationStatus

    var body: some View {
        Form {
            Section(header: Text("Daily Reminder")) {
                Toggle("Enable daily reminder", isOn: $reminderEnabled)
                    .onChange(of: reminderEnabled) { _ , newValue in
                        if newValue {
                            // if we don't have permission, request it
                            NotificationService.shared.requestPermission { granted in
                                DispatchQueue.main.async {
                                    self.authStatus = NotificationService.shared.authorizationStatus
                                    if granted {
                                        let comps = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
                                        NotificationService.shared.scheduleDailyNotification(hour: comps.hour ?? 20, minute: comps.minute ?? 0)
                                    } else {
                                        // user denied - update toggle
                                        self.reminderEnabled = false
                                    }
                                }
                            }
                        } else {
                            NotificationService.shared.cancelDailyNotification()
                        }
                    }

                DatePicker("Reminder time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    .onChange(of: reminderTime) { _ , newDate in
                        let comps = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                        if reminderEnabled {
                            NotificationService.shared.scheduleDailyNotification(hour: comps.hour ?? 20, minute: comps.minute ?? 0)
                        }
                    }

                if let status = authStatus {
                    switch status {
                    case .denied, .provisional, .ephemeral, .notDetermined:
                        if status == .denied {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Notifications are disabled for this app. Please enable them in Settings.")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Button("Open Settings") {
                                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            }
                        }
                    case .authorized:
                        EmptyView()
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            // sync initial states
            self.authStatus = NotificationService.shared.authorizationStatus
            if let saved = NotificationService.shared.savedTime() {
                self.reminderTime = saved
            }
            self.reminderEnabled = NotificationService.shared.isEnabledInSettings
        }
    }
}

#Preview {
    SettingsView()
}
