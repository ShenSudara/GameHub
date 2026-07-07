//
//  SettingsViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import Foundation
import Combine
import UserNotifications
import SwiftUI

// view model class for handle the settings view
@MainActor
class SettingsViewModel: ObservableObject {
    @Published var reminderEnabled: Bool
    @Published var reminderTime: Date
    @Published var authStatus: UNAuthorizationStatus?
    
    private let notificationService = NotificationService.shared
    
    // initialize the properties
    init() {
        self.reminderEnabled = notificationService.isEnabledInSettings
        self.reminderTime = notificationService.savedTime()
            ?? Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
        self.authStatus = notificationService.authorizationStatus
    }
    
    // when reminder is changing its value
    func onReminderToggleChanged(_ enabled: Bool) {
        if enabled {
            requestNotificationPermission()
        } else {
            notificationService.cancelDailyNotification()
        }
    }
    
    // request notification permission
    private func requestNotificationPermission() {
        notificationService.requestPermission { [weak self] granted in
            Task {
                guard let self else { return }
                self.authStatus = self.notificationService.authorizationStatus
                if granted {
                    self.scheduleNotification()
                } else {
                    self.reminderEnabled = false
                }
            }
        }
    }
    
    // when date picker time changed
    func reminderTimeChanged(_ date: Date) {
        guard reminderEnabled else { return }
        let components = Calendar.current.dateComponents(
            [.hour, .minute],
            from: date
        )
        notificationService.scheduleDailyNotification(
            hour: components.hour ?? 20,
            minute: components.minute ?? 0
        )
    }

    
    // schedule notification
    func scheduleNotification() {
        let components = Calendar.current.dateComponents(
            [.hour, .minute],
            from: reminderTime
        )

        notificationService.scheduleDailyNotification(
            hour: components.hour ?? 20,
            minute: components.minute ?? 0
        )
    }
    
    // refresh statuses
    func refresh() {
        authStatus = notificationService.authorizationStatus
        reminderEnabled = notificationService.isEnabledInSettings

        if let savedTime = notificationService.savedTime() {
            reminderTime = savedTime
        }
    }
    
    // open settings
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url)
    }

    // notification permission status is denied or not
    var notificationsDenied: Bool {
        authStatus == .denied
    }
}
