import Foundation

struct Ziyarah: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let shrine: Shrine
    let language: String // "English" or "Arabic"
    let category: ZiyarahCategory
}

enum ZiyarahCategory {
    case general
    case special
    case daily
    case occasion
} 