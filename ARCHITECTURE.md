# Architecture

This document describes the system design, module boundaries, and extensibility model for mclock.

## Overview

mclock is a modular macOS menu bar application built with Swift and SwiftUI. The architecture prioritizes:

- **Separation of concerns** — Each module has a single, well-defined responsibility
- **Protocol-oriented extensibility** — New features are added via protocols, not modifications
- **Testability** — All services are injectable and mockable
- **Contributor clarity** — Clear boundaries so hundreds of contributors can work in parallel

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                      mclock (App)                       │
│  MenuBarController · AppDelegate · SettingsWindow       │
└────────────────────────┬────────────────────────────────┘
                         │ depends on
┌────────────────────────▼────────────────────────────────┐
│                    mclockCore (Library)                  │
│                                                         │
│  ┌─────────────┐ ┌──────────────┐ ┌─────────────────┐  │
│  │  ClockService│ │ LockScreen   │ │ Authentication  │  │
│  │             │ │ Service      │ │ Service         │  │
│  └─────────────┘ └──────────────┘ └─────────────────┘  │
│  ┌─────────────┐ ┌──────────────┐ ┌─────────────────┐  │
│  │ ThemeService│ │ Settings     │ │ PluginManager   │  │
│  │             │ │ Service      │ │                 │  │
│  └─────────────┘ └──────────────┘ └─────────────────┘  │
│  ┌─────────────┐ ┌──────────────┐                      │
│  │ Monitor     │ │ Localization │                      │
│  │ Service     │ │ Service      │                      │
│  └─────────────┘ └──────────────┘                      │
└─────────────────────────────────────────────────────────┘
                         │ implements
┌────────────────────────▼────────────────────────────────┐
│              Extension Points (Protocols)                │
│                                                         │
│  AuthenticationProvider · ThemeProvider · LockMethod    │
│  SettingsPage · Plugin · LocalizationProvider           │
└─────────────────────────────────────────────────────────┘
```

## Module Structure

### mclock (Application Target)

The main application target. Responsible for:

- App lifecycle (`AppDelegate`, `@main`)
- Menu bar item rendering and interaction
- Window management (settings, lock overlay)
- Wiring services together via dependency injection

**Dependencies:** `mclockCore`

### mclockCore (Library Target)

Shared library containing all business logic, protocols, and services. This is where most contributor work happens.

**Dependencies:** Foundation, AppKit, LocalAuthentication, SwiftUI

### mclockTests (Unit Tests)

Unit tests for all services and protocols in `mclockCore`.

**Dependencies:** `mclockCore`, XCTest

### mclockUITests (UI Tests)

End-to-end UI tests for menu bar, lock screen, and settings flows.

**Dependencies:** `mclock`, XCTest

## Services

Each service follows a consistent pattern:

```swift
/// Purpose: One-line description of what this service does.
///
/// Responsibilities:
/// - Primary responsibility
/// - Secondary responsibility
///
/// Dependencies:
/// - ServiceA (for X)
/// - ServiceB (for Y)
///
/// Example Usage:
/// ```swift
/// let service = ClockService(format: .twentyFourHour)
/// service.startUpdating(every: 1.0)
/// ```
protocol ClockServiceProtocol {
    var currentTime: String { get }
    func startUpdating(every interval: TimeInterval)
    func stopUpdating()
}
```

### ClockService

**Purpose:** Manages time display formatting and periodic updates.

**Responsibilities:**
- Format current time according to user preferences
- Emit time updates at configurable intervals
- Support 12-hour and 24-hour formats

**Dependencies:** `SettingsService` (for format preferences)

### LockScreenService

**Purpose:** Controls the lock screen overlay lifecycle.

**Responsibilities:**
- Show/hide fullscreen lock overlay
- Manage lock state (locked, unlocked, authenticating)
- Trigger auto-lock based on idle timeout
- Coordinate with authentication service for unlock

**Dependencies:** `AuthenticationService`, `MonitorService`, `SettingsService`

### AuthenticationService

**Purpose:** Orchestrates authentication providers for unlock.

**Responsibilities:**
- Register and manage authentication providers
- Attempt authentication via configured providers
- Handle failure, retry, and lockout logic
- Store credentials securely via Keychain

**Dependencies:** `AuthenticationProvider` (protocol), Keychain Services

### ThemeService

**Purpose:** Manages visual theming across the application.

**Responsibilities:**
- Load and apply active theme
- Register available themes
- Provide theme values to UI components

**Dependencies:** `ThemeProvider` (protocol), `SettingsService`

### SettingsService

**Purpose:** Persists and retrieves user preferences.

**Responsibilities:**
- Read/write UserDefaults
- Provide typed access to settings
- Notify observers of setting changes

**Dependencies:** UserDefaults, `SettingsPage` (protocol)

### PluginManager

**Purpose:** Discovers, loads, and manages plugins.

**Responsibilities:**
- Scan plugin directories
- Validate plugin manifests
- Load/unload plugins at runtime
- Provide plugin API surface

**Dependencies:** `Plugin` (protocol)

### MonitorService

**Purpose:** Observes system events relevant to lock behavior.

**Responsibilities:**
- Track user idle time
- Observe app launch/termination events
- Monitor screen sleep/wake

**Dependencies:** IOKit, NSWorkspace notifications

### LocalizationService

**Purpose:** Provides localized strings throughout the app.

**Responsibilities:**
- Load language bundles
- Provide string lookup by key
- Support runtime language switching

**Dependencies:** `LocalizationProvider` (protocol)

## Extensibility Model

All extension points are defined as protocols in `mclockCore`. Contributors implement these protocols to add functionality without modifying existing code.

| Protocol | Purpose | Registration |
|----------|---------|--------------|
| `AuthenticationProvider` | Add unlock methods (Touch ID, password, etc.) | `AuthenticationService.register(_:)` |
| `ThemeProvider` | Add visual themes | `ThemeService.register(_:)` |
| `LockMethod` | Add lock triggers (idle, schedule, manual) | `LockScreenService.register(_:)` |
| `SettingsPage` | Add settings UI sections | `SettingsService.register(_:)` |
| `Plugin` | Add arbitrary functionality | `PluginManager.load(_:)` |
| `LocalizationProvider` | Add language support | `LocalizationService.register(_:)` |

See [docs/extensibility.md](docs/extensibility.md) for implementation guides and [examples/](examples/) for reference implementations.

## Dependency Injection

Services are wired together using a lightweight dependency container:

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

    init(/* injectable dependencies for testing */) { ... }
}
```

This enables:

- Unit testing with mock services
- Swapping implementations without changing consumers
- Clear dependency graphs

## Data Flow

### Lock Flow

```
User triggers lock (shortcut / idle / manual)
  → LockScreenService.lock()
    → Show overlay window
    → MonitorService.pauseIdleTracking()
    → AuthenticationService.prepareForUnlock()
      → User authenticates
        → AuthenticationProvider.authenticate()
          → Success: LockScreenService.unlock()
          → Failure: Show error, retry
```

### Clock Update Flow

```
ClockService.startUpdating(every: 1.0)
  → Timer fires
    → Read SettingsService.timeFormat
    → Format Date → String
    → Notify MenuBarController
      → Update menu bar label
```

## File Organization

```
mclockCore/
├── Authentication/
│   ├── AuthenticationService.swift
│   ├── AuthenticationProvider.swift
│   └── Providers/
│       ├── TouchIDProvider.swift
│       └── PasswordProvider.swift
├── Clock/
│   ├── ClockService.swift
│   └── TimeFormat.swift
├── LockScreen/
│   ├── LockScreenService.swift
│   ├── LockMethod.swift
│   └── LockOverlayView.swift
├── Theming/
│   ├── ThemeService.swift
│   ├── ThemeProvider.swift
│   └── Themes/
├── Settings/
│   ├── SettingsService.swift
│   ├── SettingsPage.swift
│   └── Pages/
├── Plugins/
│   ├── PluginManager.swift
│   └── Plugin.swift
├── Monitor/
│   └── MonitorService.swift
├── Localization/
│   ├── LocalizationService.swift
│   └── LocalizationProvider.swift
└── DI/
    └── ServiceContainer.swift
```

## Design Decisions

| Decision | Rationale |
|----------|-----------|
| SwiftUI for UI | Modern declarative UI, easier for contributors |
| Protocol-oriented services | Extensibility without modifying core code |
| Separate library target | Testable, reusable, clear API boundaries |
| UserDefaults for settings | Simple, no external dependencies for v1 |
| Keychain for credentials | Apple-recommended secure storage |
| No Core Data | Settings are simple key-value; avoid complexity |

## Related Documentation

- [docs/extensibility.md](docs/extensibility.md) — How to extend mclock
- [docs/services.md](docs/services.md) — Detailed service API reference
- [CODE_STYLE.md](CODE_STYLE.md) — Coding conventions
- [examples/](examples/) — Reference implementations
