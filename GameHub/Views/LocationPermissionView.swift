//
//  LocationPermissionView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-06.
//


import SwiftUI
import CoreLocation

struct LocationPermissionView: View {
    
    let onClick: () -> Void
    
    var body: some View {
        Spacer()
        VStack(spacing: 20) {
            // location status
            VStack(spacing: 12) {
                Image(systemName: "location.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.green)
                Text("Enable Location")
                    .font(.headline)
                Text("We use your location to save game's scores.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                Button {
                    onClick()
                } label: {
                    Text("Allow Location Access")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
                .tint(.green)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(radius: 4)
        }
        .padding()
        Spacer()
    }
}

#Preview {
    LocationPermissionView(onClick: {
        print("permission button clicked")
    })
}
