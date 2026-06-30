// TouchIDProvider.example.swift
// Example AuthenticationProvider using Touch ID / Face ID.
//
// Copy this file into mclockCore/Authentication/Providers/ and remove
// the .example suffix when implementing v0.3.0.
//
// Registration:
//   authenticationService.register(TouchIDProvider())

import LocalAuthentication
// import mclockCore

// struct TouchIDProvider: AuthenticationProvider {
//     var displayName: String { "Touch ID" }
//
//     var isAvailable: Bool {
//         let context = LAContext()
//         var error: NSError?
//         return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
//     }
//
//     func authenticate() async throws -> Bool {
//         let context = LAContext()
//         return try await context.evaluatePolicy(
//             .deviceOwnerAuthenticationWithBiometrics,
//             localizedReason: "Unlock mclock"
//         )
//     }
// }
