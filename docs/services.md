# Services Reference

Detailed API reference for all mclockCore services. Each service follows the same documentation pattern: purpose, responsibilities, dependencies, and example usage.

> **Note:** Service implementations will be added in v0.1.0. This document defines the intended API surface.

---

## ClockService

**Purpose:** Manages time display formatting and periodic updates for the menu bar.

**Responsibilities:**
- Format current time according to user preferences (12h/24h)
- Emit time updates at configurable intervals
- Optionally include date in the display string

**Dependencies:**
- `SettingsServiceProtocol` — reads time format preferences

**Protocol:**

```swift
protocol ClockServiceProtocol {
    /// The formatted current time string ready for menu bar display.
    var currentTime: String { get }

    /// Whether the clock is actively updating.
    var isRunning: Bool { get }

    /// Start periodic time updates.
    /// - Parameter interval: Update interval in seconds (default: 1.0).
    func startUpdating(every interval: TimeInterval)

    /// Stop periodic time updates and release the timer.
    func stopUpdating()
}
```

**Example Usage:**

```swift
let clock = ClockService(settings: settingsService)
clock.startUpdating(every: 1.0)
menuBarItem.title = clock.currentTime
```

---

## LockScreenService

**Purpose:** Controls the lock screen overlay lifecycle and lock state.

**Responsibilities:**
- Show and hide the fullscreen lock overlay
- Manage lock state transitions (unlocked → locked → authenticating → unlocked)
- Register and invoke lock methods (idle, manual, scheduled)
- Coordinate with authentication for unlock

**Dependencies:**
- `AuthenticationServiceProtocol` — handles unlock authentication
- `MonitorServiceProtocol` — tracks idle time for auto-lock
- `SettingsServiceProtocol` — reads lock preferences (timeout, etc.)

**Protocol:**

```swift
enum LockState {
    case unlocked
    case locked
    case authenticating
}

protocol LockScreenServiceProtocol {
    var state: LockState { get }

    func lock()
    func unlock()
    func register(_ method: LockMethod)
}
```

**Example Usage:**

```swift
lockScreenService.register(IdleLockMethod(timeout: 300))
lockScreenService.lock()
// User authenticates...
lockScreenService.unlock()
```

---

## AuthenticationService

**Purpose:** Orchestrates authentication providers for lock screen unlock.

**Responsibilities:**
- Register and manage authentication providers
- Attempt authentication via configured providers (in priority order)
- Handle failure, retry, and lockout after repeated failures
- Never store biometric data — delegate to LocalAuthentication

**Dependencies:**
- `AuthenticationProvider` (protocol) — individual auth methods
- Keychain Services — secure credential storage for password auth

**Protocol:**

```swift
protocol AuthenticationServiceProtocol {
    var providers: [AuthenticationProvider] { get }

    func register(_ provider: AuthenticationProvider)
    func authenticate() async throws -> Bool
}
```

**Example Usage:**

```swift
authService.register(TouchIDProvider())
authService.register(PasswordProvider(keychain: keychainService))

let success = try await authService.authenticate()
if success {
    lockScreenService.unlock()
}
```

---

## ThemeService

**Purpose:** Manages visual theming across the application.

**Responsibilities:**
- Load and apply the active theme
- Register available themes
- Provide theme values (colors, fonts) to UI components
- Notify observers when the active theme changes

**Dependencies:**
- `ThemeProvider` (protocol) — individual theme definitions
- `SettingsServiceProtocol` — persists active theme selection

**Protocol:**

```swift
protocol ThemeServiceProtocol {
    var activeTheme: ThemeProvider { get }
    var availableThemes: [ThemeProvider] { get }

    func register(_ theme: ThemeProvider)
    func setActiveTheme(_ theme: ThemeProvider)
}
```

---

## SettingsService

**Purpose:** Persists and retrieves user preferences with typed access.

**Responsibilities:**
- Read and write UserDefaults
- Provide typed property access to all settings
- Register settings pages for the settings UI
- Notify observers when settings change

**Dependencies:**
- UserDefaults
- `SettingsPage` (protocol) — modular settings UI sections

**Protocol:**

```swift
protocol SettingsServiceProtocol {
    var timeFormat: TimeFormat { get set }
    var autoLockTimeout: TimeInterval { get set }
    var activeThemeName: String { get set }

    func register(_ page: SettingsPage)
    var settingsPages: [SettingsPage] { get }
}
```

---

## PluginManager

**Purpose:** Discovers, loads, validates, and manages plugins at runtime.

**Responsibilities:**
- Scan the plugins directory for valid plugin bundles
- Validate plugin manifests (id, version, permissions)
- Load and activate plugins
- Deactivate and unload plugins
- Provide a `PluginContext` with access to core services

**Dependencies:**
- `Plugin` (protocol) — individual plugin implementations
- All core services (injected via `PluginContext`)

**Protocol:**

```swift
protocol PluginManagerProtocol {
    var loadedPlugins: [Plugin] { get }

    func load(pluginAt url: URL) throws
    func unload(pluginId: String)
    func activateAll()
    func deactivateAll()
}
```

---

## MonitorService

**Purpose:** Observes system events relevant to lock screen behavior.

**Responsibilities:**
- Track user idle time via IOKit
- Observe app launch and termination via NSWorkspace
- Monitor screen sleep and wake events
- Notify listeners of idle state changes

**Dependencies:**
- IOKit (idle time)
- NSWorkspace (app lifecycle notifications)

**Protocol:**

```swift
protocol MonitorServiceProtocol {
    var idleTime: TimeInterval { get }
    var isIdle: Bool { get }

    func startMonitoring()
    func stopMonitoring()
    func onIdleThreshold(_ threshold: TimeInterval, handler: @escaping () -> Void)
}
```

---

## LocalizationService

**Purpose:** Provides localized strings throughout the application.

**Responsibilities:**
- Load language bundles
- Provide string lookup by key
- Support runtime language switching
- Fall back to English for missing translations

**Dependencies:**
- `LocalizationProvider` (protocol) — language-specific string providers

**Protocol:**

```swift
protocol LocalizationServiceProtocol {
    var currentLanguage: String { get }

    func register(_ provider: LocalizationProvider)
    func localizedString(for key: String) -> String
    func setLanguage(_ code: String)
}
```

---

## ServiceContainer

**Purpose:** Wires all services together and provides dependency injection.

```swift
final class ServiceContainer {
    let clock: ClockServiceProtocol
    let lockScreen: LockScreenServiceProtocol
    let authentication: AuthenticationServiceProtocol
    let theme: ThemeServiceProtocol
    let settings: SettingsServiceProtocol
    let plugins: PluginManagerProtocol
    let monitor: MonitorServiceProtocol
    let localization: LocalizationServiceProtocol

    init(
        clock: ClockServiceProtocol? = nil,
        lockScreen: LockScreenServiceProtocol? = nil,
        // ... other injectable dependencies for testing
    )
}
```

Use `ServiceContainer` in production and inject mock services in tests.

---

## Related

- [ARCHITECTURE.md](../ARCHITECTURE.md) — System design overview
- [extensibility.md](extensibility.md) — How to extend services
- [CODE_STYLE.md](../CODE_STYLE.md) — Documentation conventions
