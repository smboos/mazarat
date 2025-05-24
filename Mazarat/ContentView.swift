//
//  ContentView.swift
//  Mazarat
//
//  Created by Ali Alawi on 24/05/2025.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var selectedShrine: Shrine? = shrines.first
    
    var body: some View {
        NavigationView {
            ZStack {
                ShiaColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    if locationManager.authorizationStatus == .authorizedWhenInUse || 
                       locationManager.authorizationStatus == .authorizedAlways {
                        // Compass View
                        CompassView(heading: locationManager.heading,
                                  selectedShrine: selectedShrine,
                                  userLocation: locationManager.userLocation)
                            .frame(height: 300)
                            .padding()
                        
                        // Selected Shrine Info
                        if let shrine = selectedShrine {
                            VStack(spacing: 8) {
                                Text(shrine.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(ShiaColors.primary)
                                
                                Text(shrine.description)
                                    .font(.subheadline)
                                    .foregroundColor(ShiaColors.secondary)
                                
                                if let userLocation = locationManager.userLocation {
                                    let shrineLocation = CLLocation(latitude: shrine.latitude, 
                                                                 longitude: shrine.longitude)
                                    let distance = userLocation.distance(from: shrineLocation) / 1000
                                    Text(String(format: "Distance: %.1f km", distance))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5)
                            )
                        }
                        
                        // Shrine List
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(shrines) { shrine in
                                    Button(action: {
                                        selectedShrine = shrine
                                    }) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(shrine.name)
                                                    .font(.headline)
                                                    .foregroundColor(ShiaColors.primary)
                                                Text(shrine.description)
                                                    .font(.subheadline)
                                                    .foregroundColor(ShiaColors.secondary)
                                            }
                                            
                                            Spacer()
                                            
                                            if selectedShrine?.id == shrine.id {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(ShiaColors.accent)
                                            }
                                        }
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white)
                                                .shadow(color: Color.black.opacity(0.1), radius: 2)
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        LocationPermissionView()
                    }
                }
                .padding()
            }
            .navigationTitle("Mazarat")
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
}

struct LocationPermissionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "location.slash")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(ShiaColors.primary)
            
            Text("Location Permission Needed")
                .font(.headline)
            
            Text("Please enable location services in Settings to use the compass.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Open Settings")
                    .foregroundColor(.white)
                    .padding()
                    .background(ShiaColors.primary)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

// Shrine data
let shrines = [
    // Iraq
    Shrine(name: "Najaf", latitude: 32.0121, longitude: 44.3222, description: "Imam Ali (as)"),
    Shrine(name: "Karbala", latitude: 32.6160, longitude: 44.0249, description: "Imam Hussain (as)"),
    Shrine(name: "Al-Kadhimiya", latitude: 33.3790, longitude: 44.3449, description: "Imam Musa al-Kadhim (as), Imam Muhammad al-Jawad (as)"),
    Shrine(name: "Samarra", latitude: 34.2040, longitude: 43.8740, description: "Imam Ali al-Hadi (as), Imam Hasan al-Askari (as)"),
    Shrine(name: "Sayyidah Zaynab (Iraq)", latitude: 33.4442, longitude: 36.3483, description: "Sayyidah Zaynab (sa)"),
    
    // Iran
    Shrine(name: "Mashhad", latitude: 36.2605, longitude: 59.6168, description: "Imam Reza (as)"),
    Shrine(name: "Qom", latitude: 34.6416, longitude: 50.8746, description: "Sayyidah Fatimah al-Ma'sumah (sa)"),
    Shrine(name: "Shah Abdol-Azim", latitude: 35.5517, longitude: 51.4397, description: "Shah Abdol-Azim (ra)"),
    Shrine(name: "Shah Cheragh", latitude: 29.5917, longitude: 52.5833, description: "Shah Cheragh (ra)"),
    
    // Saudi Arabia
    Shrine(name: "Medina", latitude: 24.4672, longitude: 39.6111, description: "Imam Hasan (as), Prophet Muhammad (saw)"),
    Shrine(name: "Jannatul Baqi", latitude: 24.4672, longitude: 39.6111, description: "Cemetery of many Ahlul Bayt"),
    
    // Syria
    Shrine(name: "Sayyidah Zaynab (Syria)", latitude: 33.4442, longitude: 36.3483, description: "Sayyidah Zaynab (sa)"),
    Shrine(name: "Sayyidah Ruqayyah", latitude: 33.5131, longitude: 36.2919, description: "Sayyidah Ruqayyah (sa)"),
    Shrine(name: "Sayyidah Sakina", latitude: 33.5131, longitude: 36.2919, description: "Sayyidah Sakina (sa)"),
    
    // Pakistan
    Shrine(name: "Data Darbar", latitude: 31.5820, longitude: 74.3294, description: "Data Ganj Bakhsh (ra)"),
    
    // India
    Shrine(name: "Hazratbal", latitude: 34.1247, longitude: 74.8389, description: "Relic of Prophet Muhammad (saw)"),
    
    // Other Important Shrines
    Shrine(name: "Imamzadeh Hamzeh", latitude: 35.7219, longitude: 51.3347, description: "Imamzadeh Hamzeh (ra)"),
    Shrine(name: "Imamzadeh Saleh", latitude: 35.7219, longitude: 51.3347, description: "Imamzadeh Saleh (ra)"),
    Shrine(name: "Bibi Shahrbanu", latitude: 35.5517, longitude: 51.4397, description: "Bibi Shahrbanu (sa)"),
    Shrine(name: "Imamzadeh Ja'far", latitude: 35.7219, longitude: 51.3347, description: "Imamzadeh Ja'far (ra)")
]
