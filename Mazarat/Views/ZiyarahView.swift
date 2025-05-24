import SwiftUI

struct ZiyarahView: View {
    let shrine: Shrine
    @State private var selectedCategory: ZiyarahCategory = .general
    @State private var showingTranslation = false
    
    var filteredZiyarat: [Ziyarah] {
        ziyarat.filter { $0.shrine.id == shrine.id }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Category Picker
                Picker("Category", selection: $selectedCategory) {
                    ForEach(ZiyarahCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Ziyarah List
                ForEach(filteredZiyarat) { ziyarah in
                    VStack(alignment: .leading, spacing: 15) {
                        // Title and Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text(ziyarah.title)
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .foregroundColor(ShiaColors.primary)
                            
                            if let time = ziyarah.recommendedTime {
                                HStack {
                                    Image(systemName: "clock")
                                    Text("Recommended: \(time)")
                                }
                                .font(.custom("AvenirNext-Regular", size: 14))
                                .foregroundColor(ShiaColors.secondary)
                            }
                            
                            if let source = ziyarah.source {
                                HStack {
                                    Image(systemName: "book")
                                    Text("Source: \(source)")
                                }
                                .font(.custom("AvenirNext-Regular", size: 14))
                                .foregroundColor(ShiaColors.secondary)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Arabic Text
                        VStack(alignment: .trailing, spacing: 10) {
                            Text(ziyarah.arabicText)
                                .font(.custom("AvenirNext-Regular", size: 24))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(ShiaColors.primary)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                                )
                            
                            // Translation Toggle
                            Button(action: {
                                withAnimation {
                                    showingTranslation.toggle()
                                }
                            }) {
                                HStack {
                                    Text(showingTranslation ? "Hide Translation" : "Show Translation")
                                    Image(systemName: showingTranslation ? "chevron.up" : "chevron.down")
                                }
                                .font(.custom("AvenirNext-Regular", size: 14))
                                .foregroundColor(ShiaColors.accent)
                            }
                            
                            // Translation
                            if showingTranslation {
                                Text(ziyarah.translation)
                                    .font(.custom("AvenirNext-Regular", size: 16))
                                    .foregroundColor(ShiaColors.deepBlue)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .padding(.vertical)
        }
        .background(ShiaColors.background)
        .navigationTitle("Ziyarah")
    }
}

#Preview {
    NavigationView {
        ZiyarahView(shrine: shrines[0])
    }
} 