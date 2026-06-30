import Foundation

/// A modular section in the settings window.
public protocol SettingsPage: Sendable {
    /// Section title shown in the settings sidebar.
    var title: String { get }

    /// SF Symbol name for the settings sidebar icon.
    var icon: String { get }
}
