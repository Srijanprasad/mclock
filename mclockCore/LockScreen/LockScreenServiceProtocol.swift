import Foundation

/// Lock screen state transitions.
public enum LockState: Sendable {
    case unlocked
    case locked
    case authenticating
}

/// Controls the lock screen overlay lifecycle and lock state.
public protocol LockScreenServiceProtocol: AnyObject {
    var state: LockState { get }

    func lock()
    func unlock()
    func register(_ method: LockMethod)
}
