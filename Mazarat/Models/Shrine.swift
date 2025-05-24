import Foundation
import CoreLocation

struct Shrine: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let description: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
} 