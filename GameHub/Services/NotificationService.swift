//
//  NotificationService.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-07.
//

import Foundation
import UserNotifications
import SwiftUI
import Combine

// manage the notification permission
final class NotificationService: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationService()

    private let center = UNUserNotificationCenter.current()
    @Published var authorizationStatus: UNAuthorizationStatus?

    private let notificationTimeKey = "GameHubNotificationTimeMinutes"
    private let notificationEnabledKey = "GameHubNotificationEnabled"

    // read the current settings
    override init() {
        super.init()
        center.delegate = self
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }

    // request permission from user
    func requestPermission(completion: ((Bool) -> Void)? = nil) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            self.center.getNotificationSettings { settings in
                DispatchQueue.main.async {
                    self.authorizationStatus = settings.authorizationStatus
                    completion?(granted)
                }
            }
        }
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.banner, .sound, .badge]
    }

    // schedule a daily notification
    func scheduleDailyNotification(hour: Int, minute: Int, title: String = "Time to play!", body: String = "Open GameHub and play your daily game.") {
        // only schedule if authorization is allowed
        guard authorizationStatus == .authorized || authorizationStatus == .provisional || authorizationStatus == .ephemeral else {
            return
        }

        // remove previous pending notifications
        center.removePendingNotificationRequests(withIdentifiers: ["gamehub_daily_game_reminder"])

        // create a new notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "gamehub_daily_game_reminder", content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                // persist selected time
                let minutes = hour * 60 + minute
                UserDefaults.standard.set(minutes, forKey: self.notificationTimeKey)
                UserDefaults.standard.set(true, forKey: self.notificationEnabledKey)
                print("Scheduled daily notification at \(hour):\(String(format: "%02d", minute))")
            }
        }
    }

    // Cancel daily reminder
    func cancelDailyNotification() {
        center.removePendingNotificationRequests(withIdentifiers: ["gamehub_daily_game_reminder"])
        UserDefaults.standard.set(false, forKey: notificationEnabledKey)
    }

    // get whether notifications are enabled
    var isEnabledInSettings: Bool {
        UserDefaults.standard.bool(forKey: notificationEnabledKey)
    }

    // Return the stored notification time as Date
    func savedTime() -> Date? {
        let minutes = UserDefaults.standard.integer(forKey: notificationTimeKey)
        if minutes <= 0 { return nil }
        var components = DateComponents()
        components.hour = minutes / 60
        components.minute = minutes % 60
        return Calendar.current.date(from: components)
    }
}
