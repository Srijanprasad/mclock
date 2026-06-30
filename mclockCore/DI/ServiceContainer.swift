import Foundation

/// Wires core services together and provides dependency injection.
///
/// Purpose: Central registry for all application services.
///
/// Responsibilities:
/// - Construct and expose service instances
/// - Enable dependency injection for tests
///
/// Dependencies:
/// - Individual service implementations in `mclockCore`
///
/// Example Usage:
/// ```swift
/// let container = ServiceContainer()
/// container.clockService.startUpdating(every: 1.0)
/// ```
@MainActor
public final class ServiceContainer: ObservableObject {
    public let settings: SettingsServiceProtocol
    public let clockService: ClockService

    public var clock: ClockServiceProtocol { clockService }

    public init(
        settings: SettingsServiceProtocol? = nil,
        clock: ClockService? = nil
    ) {
        let settingsService = settings ?? SettingsService()
        self.settings = settingsService
        self.clockService = clock ?? ClockService(settings: settingsService)
    }

    /// Starts default services for the running application.
    public func startServices() {
        clockService.startUpdating(every: 1.0)
    }

    /// Stops services before application termination.
    public func stopServices() {
        clockService.stopUpdating()
    }
}
