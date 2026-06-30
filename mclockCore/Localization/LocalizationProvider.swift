import Foundation

/// Provides localized strings for a specific language.
public protocol LocalizationProvider: Sendable {
    var languageCode: String { get }
    var displayName: String { get }

    func localizedString(for key: String) -> String
}
