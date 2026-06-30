import Foundation

/// Defines a trigger mechanism for the lock screen.
public protocol LockMethod: Sendable {
    /// Human-readable name for this lock method.
    var name: String { get }

    /// Begin monitoring for lock conditions.
    func startMonitoring(onLock: @escaping @Sendable () -> Void)

    /// Stop monitoring and release resources.
    func stopMonitoring()
}
