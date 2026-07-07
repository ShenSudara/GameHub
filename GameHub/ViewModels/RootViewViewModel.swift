//
//  RootViewViewModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-06.
//

import SwiftUI
import CoreLocation
import Combine

class RootViewViewModel: ObservableObject {
    @Published var flowState: AppFlowState = .loading
    let locationManager: LocationPermissionManager = .shared
    let notificationManager: NotificationService = .shared
    private var cancellables = Set<AnyCancellable>()
    
    // update the application flow
    func updateFlow(for locationStatus: CLAuthorizationStatus?, for notificationStatus: UNAuthorizationStatus?) {
        guard let locationStatus else {
            flowState = .needsLocationPermission
            return
        }
        guard let notificationStatus else {
            flowState = .needsNotificationPermission
            return
        }

        // check the current application flow state and update
        switch locationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // location is allowed, check notifications
            switch notificationStatus {
            case .authorized, .provisional, .ephemeral:
                flowState = .goToHome
            case .notDetermined:
                flowState = .needsNotificationPermission
            case .denied:
                flowState = .goToHome
            @unknown default:
                flowState = .needsNotificationPermission
            }
        case .notDetermined:
            flowState = .needsLocationPermission
        case .denied, .restricted:
            flowState = .needsLocationPermission
        @unknown default:
            flowState = .needsLocationPermission
        }
    }

    // add 3 seconds delay and show permission view
    func startLoadingWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // After 3 seconds, check current authorization status and update it
            self.updateFlow(for: self.locationManager.authorizationStatus, for: self.notificationManager.authorizationStatus)
            
            // subscribe to future authorization status changes
            self.locationManager.$authorizationStatus
                .receive(on: DispatchQueue.main)
                .sink { [weak self] status in
                    self?.updateFlow(for: status, for: self?.notificationManager.authorizationStatus)
                }
                .store(in: &self.cancellables)

            // subscribe to notification authorization changes
            self.notificationManager.$authorizationStatus
                .receive(on: DispatchQueue.main)
                .sink { [weak self] status in
                    self?.updateFlow(for: self?.locationManager.authorizationStatus, for: status)
                }
                .store(in: &self.cancellables)
        }
    }
}

