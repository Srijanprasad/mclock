import Foundation

/// Formats and publishes time updates for the menu bar display.
///
/// Responsibilities:
/// - Format current time according to user preferences
/// - Emit time updates at configurable intervals
///
/// Dependencies:
/// - `SettingsServiceProtocol` for time format preferences
///
/// Example Usage:
/// ```swift
/// let clock = ClockService(settings: settingsService)
/// clock.startUpdating(every: 1.0)
/// print(clock.currentTime)
/// ```
public protocol ClockServiceProtocol: AnyObject {
    /// The formatted current time string ready for menu bar display.
    var currentTime: String { get }

    /// Whether the clock is actively updating.
    var isRunning: Bool { get }

    /// Start periodic time updates.
    /// - Parameter interval: Update interval in seconds.
    func startUpdating(every interval: TimeInterval)

    /// Stop periodic time updates and release the timer.
    func stopUpdating()
}
