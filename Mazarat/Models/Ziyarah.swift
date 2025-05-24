import Foundation

struct Ziyarah: Identifiable {
    let id = UUID()
    let title: String
    let arabicText: String
    let translation: String
    let shrine: Shrine
    let category: ZiyarahCategory
    let recommendedTime: String?
    let source: String?
}

enum ZiyarahCategory: String, CaseIterable {
    case general = "General"
    case special = "Special"
    case daily = "Daily"
    case occasion = "Special Occasion"
}

// Sample Ziyarah data
let ziyarat = [
    // Imam Ali (as) - Najaf
    Ziyarah(
        title: "Ziyarat of Imam Ali (as)",
        arabicText: """
        السَّلامُ عَلَيْكَ يا أَمِيرَ الْمُؤْمِنِينَ
        السَّلامُ عَلَيْكَ يا وَصِيَّ رَسُولِ رَبِّ الْعالَمِينَ
        السَّلامُ عَلَيْكَ يا أَخا رَسُولِ رَبِّ الْعالَمِينَ
        السَّلامُ عَلَيْكَ يا أَوَّلَ الْوَصِيِّينَ
        السَّلامُ عَلَيْكَ يا أَوَّلَ الْمُؤْمِنِينَ
        السَّلامُ عَلَيْكَ يا أَوَّلَ الْمُسْلِمِينَ
        """,
        translation: """
        Peace be upon you, O Commander of the Faithful
        Peace be upon you, O Successor of the Messenger of the Lord of the worlds
        Peace be upon you, O Brother of the Messenger of the Lord of the worlds
        Peace be upon you, O First of the Successors
        Peace be upon you, O First of the Believers
        Peace be upon you, O First of the Muslims
        """,
        shrine: shrines[0], // Najaf
        category: .general,
        recommendedTime: "Any time",
        source: "Mafatih al-Jinan"
    ),
    
    // Imam Hussain (as) - Karbala
    Ziyarah(
        title: "Ziyarat of Imam Hussain (as)",
        arabicText: """
        السَّلامُ عَلَيْكَ يا أَبا عَبْدِ اللهِ
        السَّلامُ عَلَيْكَ يا ابْنَ أَمِيرِ الْمُؤْمِنِينَ
        السَّلامُ عَلَيْكَ يا ابْنَ فاطِمَةَ الزَّهْراءِ
        السَّلامُ عَلَيْكَ يا ثارَ اللهِ وَابْنَ ثارِهِ
        السَّلامُ عَلَيْكَ يا وَتِيرَ اللهِ وَابْنَ وَتِيرِهِ
        """,
        translation: """
        Peace be upon you, O Aba Abdillah
        Peace be upon you, O Son of the Commander of the Faithful
        Peace be upon you, O Son of Fatima al-Zahra
        Peace be upon you, O the one whose blood was shed for Allah and son of the one whose blood was shed for Allah
        Peace be upon you, O the one who was killed for Allah and son of the one who was killed for Allah
        """,
        shrine: shrines[1], // Karbala
        category: .special,
        recommendedTime: "Morning and Evening",
        source: "Mafatih al-Jinan"
    )
] 