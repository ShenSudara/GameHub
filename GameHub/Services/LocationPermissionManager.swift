//
//  LocationPermissionManager.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-06.
//


import Foundation
import CoreLocation
import SwiftUI
import Combine

// location manager class for handle location permission
final class LocationPermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = manager.authorizationStatus
    }

    // request permission
    func requestPermission() {
       manager.requestWhenInUseAuthorization()
    }

    // start tracking
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }

    // if permission changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        authorizationStatus = status
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            break
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }

    // update current location
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location.coordinate
        }
    }

    // location manager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
