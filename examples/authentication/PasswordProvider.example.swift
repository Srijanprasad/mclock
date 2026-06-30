// PasswordProvider.example.swift
// Example AuthenticationProvider using password authentication with Keychain storage.
//
// Copy this file into mclockCore/Authentication/Providers/ and remove
// the .example suffix when implementing v0.3.0.
//
// Registration:
//   authenticationService.register(PasswordProvider(keychain: keychainService))

// import mclockCore

// struct PasswordProvider: AuthenticationProvider {
//     var displayName: String { "Password" }
//     var isAvailable: Bool { true }
//
//     private let keychain: KeychainServiceProtocol
//
//     init(keychain: KeychainServiceProtocol) {
//         self.keychain = keychain
//     }
//
//     func authenticate() async throws -> Bool {
//         // Present password input UI and validate against Keychain-stored hash
//         // Return true on successful match
//         return false
//     }
// }
