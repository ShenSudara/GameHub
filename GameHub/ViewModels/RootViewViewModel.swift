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
    let locationManager: LocationPermissionManager = LocationPermissionManager()
    private var cancellables = Set<AnyCancellable>()
    
    // update the application flow
    func updateFlow(for status: CLAuthorizationStatus?) {
        guard let status else {
            flowState = .needsLocationPermission
            return
        }

        // check the current application flow state and update
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            flowState = .goToHome
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
            self.updateFlow(for: self.locationManager.authorizationStatus)
            
            // subscribe to future authorization status changes
            self.locationManager.$authorizationStatus
                .receive(on: DispatchQueue.main)
                .sink { [weak self] status in
                    self?.updateFlow(for: status)
                }
                .store(in: &self.cancellables)
        }
    }
}
