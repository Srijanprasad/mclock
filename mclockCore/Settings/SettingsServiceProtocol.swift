import Foundation

/// Persists and retrieves user preferences with typed access.
///
/// Responsibilities:
/// - Read and write user preferences
/// - Provide typed property access to settings
///
/// Dependencies:
/// - UserDefaults
///
/// Example Usage:
/// ```swift
/// let settings = SettingsService()
/// settings.timeFormat = .twentyFourHour
/// ```
public protocol SettingsServiceProtocol: AnyObject {
    /// Clock display format preference.
    var timeFormat: TimeFormat { get set }
}
