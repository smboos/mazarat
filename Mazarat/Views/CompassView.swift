import SwiftUI
import CoreLocation

struct CompassView: View {
    let heading: Double
    let selectedShrine: Shrine?
    let userLocation: CLLocation?
    
    var body: some View {
        ZStack {
            // Background circle with Islamic pattern
            Circle()
                .fill(ShiaColors.background)
                .frame(width: 300, height: 300)
                .overlay(
                    Circle()
                        .stroke(ShiaColors.primary, lineWidth: 3)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 10)
            
            // Islamic geometric pattern
            ForEach(0..<8) { i in
                Path { path in
                    let center = CGPoint(x: 150, y: 150)
                    let radius: CGFloat = 140
                    let angle = Double(i) * .pi / 4
                    
                    path.move(to: center)
                    path.addLine(to: CGPoint(
                        x: center.x + radius * cos(angle),
                        y: center.y + radius * sin(angle)
                    ))
                }
                .stroke(ShiaColors.primary.opacity(0.3), lineWidth: 1)
            }
            
            // Direction markers with Arabic-inspired font
            ForEach(0..<8) { i in
                VStack(spacing: 5) {
                    Text(directionText(for: i))
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(ShiaColors.primary)
                    
                    Rectangle()
                        .fill(ShiaColors.primary.opacity(0.5))
                        .frame(width: 2, height: 15)
                }
                .offset(y: -140)
                .rotationEffect(.degrees(Double(i) * 45))
            }
            
            // Compass needle with Islamic design
            ZStack {
                // Decorative circle in the center
                Circle()
                    .fill(ShiaColors.accent)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(ShiaColors.primary, lineWidth: 2)
                    )
                
                // Main compass needle
                Image(systemName: "location.north.fill")
                    .resizable()
                    .frame(width: 20, height: 200)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [ShiaColors.primary, ShiaColors.secondary],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .rotationEffect(.degrees(-heading))
            }
            
            // Direction to shrine with Islamic-inspired arrow
            if let shrine = selectedShrine,
               let userLocation = userLocation {
                let shrineLocation = CLLocation(latitude: shrine.latitude,
                                             longitude: shrine.longitude)
                let bearing = calculateBearing(from: userLocation.coordinate,
                                            to: shrineLocation.coordinate)
                
                ZStack {
                    // Decorative circle around the arrow
                    Circle()
                        .stroke(ShiaColors.accent, lineWidth: 2)
                        .frame(width: 40, height: 40)
                    
                    // Custom arrow design
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [ShiaColors.accent, ShiaColors.secondary],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
                .rotationEffect(.degrees(bearing - heading))
            }
        }
        .frame(width: 300, height: 300)
    }
    
    private func directionText(for index: Int) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        return directions[index]
    }
    
    private func calculateBearing(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let lat1 = from.latitude * .pi / 180
        let lon1 = from.longitude * .pi / 180
        let lat2 = to.latitude * .pi / 180
        let lon2 = to.longitude * .pi / 180
        
        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let bearing = atan2(y, x) * 180 / .pi
        
        return (bearing + 360).truncatingRemainder(dividingBy: 360)
    }
} 