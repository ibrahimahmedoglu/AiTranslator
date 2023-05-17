import Foundation

class TranslationResponse: Codable {
    let translations: [Translation]
    
    init(translations: [Translation]) {
        self.translations = translations
    }
}

class Translation: Codable {
    let detected_source_language: String
    let text: String
    
    init(detected_source_language: String, text: String) {
        self.detected_source_language = detected_source_language
        self.text = text
    }
}
