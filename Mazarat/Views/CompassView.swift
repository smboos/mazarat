import SwiftUI
import CoreLocation

struct CompassView: View {
    let heading: Double
    let selectedShrine: Shrine?
    let userLocation: CLLocation?
    
    var body: some View {
        ZStack {
            // Outer circle
            Circle()
                .stroke(ShiaColors.primary, lineWidth: 2)
                .frame(width: 250, height: 250)
            
            // Direction markers
            ForEach(0..<8) { i in
                VStack {
                    Text(directionText(for: i))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(ShiaColors.primary)
                    Rectangle()
                        .fill(ShiaColors.primary.opacity(0.5))
                        .frame(width: 2, height: 15)
                }
                .offset(y: -125)
                .rotationEffect(.degrees(Double(i) * 45))
            }
            
            // Compass needle
            Image(systemName: "location.north.fill")
                .resizable()
                .frame(width: 20, height: 200)
                .foregroundColor(ShiaColors.secondary)
                .rotationEffect(.degrees(-heading))
            
            // Direction to shrine
            if let shrine = selectedShrine,
               let userLocation = userLocation {
                let shrineLocation = CLLocation(latitude: shrine.latitude,
                                             longitude: shrine.longitude)
                let bearing = calculateBearing(from: userLocation.coordinate,
                                            to: shrineLocation.coordinate)
                
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(ShiaColors.accent)
                    .rotationEffect(.degrees(bearing - heading))
            }
        }
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