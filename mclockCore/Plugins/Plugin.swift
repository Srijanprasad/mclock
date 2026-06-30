import Foundation

/// Runtime context provided to plugins during activation.
public struct PluginContext {
    public let clockService: ClockServiceProtocol

    public init(clockService: ClockServiceProtocol) {
        self.clockService = clockService
    }
}

/// Self-contained extension loaded at runtime.
public protocol Plugin {
    var id: String { get }
    var name: String { get }
    var version: String { get }

    func activate(in context: PluginContext)
    func deactivate()
}
