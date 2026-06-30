import Foundation

/// Observes system events relevant to lock screen behavior.
public protocol MonitorServiceProtocol: AnyObject {
    var idleTime: TimeInterval { get }
    var isIdle: Bool { get }

    func startMonitoring()
    func stopMonitoring()
    func onIdleThreshold(_ threshold: TimeInterval, handler: @escaping () -> Void)
}
