import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                Text("About Mazarat")
                    .font(.custom("AvenirNext-Bold", size: 32))
                    .foregroundColor(ShiaColors.primary)
                    .padding(.bottom, 10)
                
                // App Description
                VStack(alignment: .leading, spacing: 15) {
                    Text("Purpose")
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .foregroundColor(ShiaColors.primary)
                    
                    Text("Mazarat is designed to help you find the direction to Shia holy shrines while reciting Ziyarah. The app combines modern technology with traditional Islamic navigation to guide you towards these sacred places.")
                        .font(.custom("AvenirNext-Regular", size: 16))
                        .foregroundColor(ShiaColors.deepBlue)
                }
                .padding(.bottom)
                
                // Features
                VStack(alignment: .leading, spacing: 15) {
                    Text("Features")
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .foregroundColor(ShiaColors.primary)
                    
                    FeatureRow(icon: "location.fill", title: "Compass Navigation", description: "Find the exact direction to holy shrines with our Islamic-inspired compass")
                    FeatureRow(icon: "map.fill", title: "Shrine Directory", description: "Access information about major Shia shrines worldwide")
                    FeatureRow(icon: "text.book.closed.fill", title: "Ziyarah Support", description: "Recite Ziyarah while being guided to the shrine")
                    FeatureRow(icon: "ruler.fill", title: "Distance Tracking", description: "Know how far you are from your destination")
                }
                .padding(.bottom)
                
                // How to Use
                VStack(alignment: .leading, spacing: 15) {
                    Text("How to Use")
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .foregroundColor(ShiaColors.primary)
                    
                    Text("1. Select a shrine from the list")
                        .font(.custom("AvenirNext-Regular", size: 16))
                    Text("2. Allow location access when prompted")
                        .font(.custom("AvenirNext-Regular", size: 16))
                    Text("3. Follow the compass direction")
                        .font(.custom("AvenirNext-Regular", size: 16))
                    Text("4. Begin your Ziyarah")
                        .font(.custom("AvenirNext-Regular", size: 16))
                }
                .padding(.bottom)
                
                // Version
                VStack(alignment: .leading, spacing: 5) {
                    Text("Version 1.0")
                        .font(.custom("AvenirNext-Regular", size: 14))
                        .foregroundColor(ShiaColors.secondary)
                    
                    Text("© 2024 Mazarat")
                        .font(.custom("AvenirNext-Regular", size: 14))
                        .foregroundColor(ShiaColors.secondary)
                }
            }
            .padding()
        }
        .background(ShiaColors.background)
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(ShiaColors.accent)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.custom("AvenirNext-Bold", size: 16))
                    .foregroundColor(ShiaColors.primary)
                
                Text(description)
                    .font(.custom("AvenirNext-Regular", size: 14))
                    .foregroundColor(ShiaColors.deepBlue)
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    AboutView()
} 