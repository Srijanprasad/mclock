// IdleLockMethod.example.swift
// Example LockMethod that triggers lock after a period of user inactivity.
//
// Copy into mclockCore/LockScreen/Methods/ when implementing v0.2.0.
//
// Registration:
//   lockScreenService.register(IdleLockMethod(timeout: 300))

// import mclockCore

// struct IdleLockMethod: LockMethod {
//     var name: String { "Idle Lock" }
//
//     private let timeout: TimeInterval
//     private var monitor: MonitorServiceProtocol?
//
//     init(timeout: TimeInterval) {
//         self.timeout = timeout
//     }
//
//     func startMonitoring(onLock: @escaping () -> Void) {
//         monitor?.onIdleThreshold(timeout, handler: onLock)
//     }
//
//     func stopMonitoring() {
//         monitor?.stopMonitoring()
//     }
// }
