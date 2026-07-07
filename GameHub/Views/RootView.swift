//
//  ContentView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-01.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewViewModel()
    
    var body: some View {
        Group {
            // check the application initial flow
            switch viewModel.flowState {
            case .loading:
                // custom splash screen with integrated progress indicator
                SplashView()
                    .onAppear {
                        viewModel.startLoadingWithDelay()
                    }
            case .needsLocationPermission:
                LocationPermissionView(onClick: {
                    viewModel.locationManager.requestPermission()
                })
            case .needsNotificationPermission:
                NotificationPermissionView(onClick: {
                    viewModel.notificationManager.requestPermission()
                })
            case .goToHome:
                TabBarView()
            }
        }
    }
}

#Preview {
    RootView()
}
