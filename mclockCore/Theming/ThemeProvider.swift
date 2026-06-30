import Foundation

/// Defines a visual theme for the clock and lock screen.
public protocol ThemeProvider: Sendable {
    /// Theme display name shown in settings.
    var name: String { get }
}
