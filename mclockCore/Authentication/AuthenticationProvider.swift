import Foundation

/// Authenticates the user to unlock the lock screen.
public protocol AuthenticationProvider: Sendable {
    /// Human-readable name shown in settings (e.g., "Touch ID").
    var displayName: String { get }

    /// Whether this provider is available on the current device.
    var isAvailable: Bool { get }

    /// Attempt authentication. Returns `true` on success.
    func authenticate() async throws -> Bool
}
