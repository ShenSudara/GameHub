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
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.startLoadingWithDelay()
                    }
                    .tint(.green)
            case .needsLocationPermission:
                LocationPermissionView(onClick: {
                    viewModel.locationManager.requestPermission()
                })
            case .goToHome:
                NavigationStack {
                    HomeView()
                }
            }
        }
    }
}

#Preview {
    RootView()
}
