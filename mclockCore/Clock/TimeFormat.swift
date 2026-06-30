import Foundation

/// Supported clock display formats.
public enum TimeFormat: String, Codable, Sendable, CaseIterable {
    case twelveHour
    case twentyFourHour
}
