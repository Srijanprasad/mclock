// EnglishLocalization.example.swift
// Example LocalizationProvider for English (default language).
//
// Copy into mclockCore/Localization/Providers/ when implementing v1.0.0.
//
// Registration:
//   localizationService.register(EnglishLocalization())

// import mclockCore

// struct EnglishLocalization: LocalizationProvider {
//     var languageCode: String { "en" }
//     var displayName: String { "English" }
//
//     private let strings: [String: String] = [
//         "lock_screen.title": "Locked",
//         "lock_screen.unlock": "Unlock",
//         "settings.general": "General",
//         "settings.appearance": "Appearance",
//         "menu.lock": "Lock",
//         "menu.settings": "Settings",
//         "menu.quit": "Quit mclock",
//     ]
//
//     func localizedString(for key: String) -> String {
//         strings[key] ?? key
//     }
// }
