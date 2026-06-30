# Extensibility Guide

mclock is designed so contributors can add functionality without modifying existing code. This guide explains each extension point and how to use it.

## Design Principles

1. **Protocol-first** — Extension points are Swift protocols, not subclassing
2. **Registration, not modification** — Register your implementation with the appropriate service
3. **Self-contained** — Each extension lives in its own module or directory
4. **Discoverable** — Services scan directories or accept explicit registration

## Extension Points

### AuthenticationProvider

Add new unlock methods (Touch ID, password, hardware key, etc.).

```swift
import mclockCore

struct HardwareKeyProvider: AuthenticationProvider {
    var displayName: String { "Security Key" }
    var isAvailable: Bool { /* check for connected key */ true }

    func authenticate() async throws -> Bool {
        // Implement authentication logic
        return true
    }
}

// Register at app startup
authenticationService.register(HardwareKeyProvider())
```

**Location:** `mclockCore/Authentication/AuthenticationProvider.swift`

**Example:** [examples/authentication/](../examples/authentication/)

---

### ThemeProvider

Add visual themes for the clock and lock screen.

```swift
import mclockCore

struct SolarizedTheme: ThemeProvider {
    var name: String { "Solarized" }
    var clockTextColor: Color { Color(red: 0.4, green: 0.48, blue: 0.57) }
    var lockBackgroundColor: Color { Color(red: 0.0, green: 0.17, blue: 0.21) }
    var accentColor: Color { Color(red: 0.15, green: 0.55, blue: 0.82) }
}

themeService.register(SolarizedTheme())
```

**Location:** `mclockCore/Theming/ThemeProvider.swift`

**Example:** [examples/themes/](../examples/themes/)

---

### LockMethod

Add new ways to trigger the lock screen.

```swift
import mclockCore

struct ScheduledLockMethod: LockMethod {
    var name: String { "Scheduled Lock" }

    func startMonitoring(onLock: @escaping () -> Void) {
        // Lock at a specific time each day
    }

    func stopMonitoring() {
        // Clean up timer
    }
}

lockScreenService.register(ScheduledLockMethod())
```

**Location:** `mclockCore/LockScreen/LockMethod.swift`

**Example:** [examples/lock-methods/](../examples/lock-methods/)

---

### SettingsPage

Add new sections to the settings window.

```swift
import mclockCore
import SwiftUI

struct AdvancedSettingsPage: SettingsPage {
    var title: String { "Advanced" }
    var icon: String { "gearshape.2" }

    func makeView() -> AnyView {
        AnyView(AdvancedSettingsView())
    }
}

settingsService.register(AdvancedSettingsPage())
```

**Location:** `mclockCore/Settings/SettingsPage.swift`

**Example:** [examples/settings/](../examples/settings/)

---

### Plugin

Add arbitrary functionality via the plugin system.

```swift
import mclockCore

struct PomodoroPlugin: Plugin {
    var id: String { "com.example.pomodoro" }
    var name: String { "Pomodoro Timer" }
    var version: String { "1.0.0" }

    func activate(in context: PluginContext) {
        // Access services via context
        context.clockService.startUpdating(every: 60)
    }

    func deactivate() {
        // Clean up
    }
}
```

**Location:** `mclockCore/Plugins/Plugin.swift`

**Example:** [examples/plugins/](../examples/plugins/)

See [plugin-development.md](plugin-development.md) for the full plugin authoring guide.

---

### LocalizationProvider

Add support for new languages.

```swift
import mclockCore

struct FrenchLocalization: LocalizationProvider {
    var languageCode: String { "fr" }
    var displayName: String { "Français" }

    func localizedString(for key: String) -> String {
        // Return translated string for key
        frenchStrings[key] ?? key
    }
}

localizationService.register(FrenchLocalization())
```

**Location:** `mclockCore/Localization/LocalizationProvider.swift`

**Example:** [examples/localization/](../examples/localization/)

---

## Registration Patterns

### At App Startup

Most extensions are registered during app initialization:

```swift
@main
struct MClockApp: App {
    init() {
        let container = ServiceContainer()
        container.authentication.register(TouchIDProvider())
        container.authentication.register(PasswordProvider())
        container.theme.register(LightTheme())
        container.theme.register(DarkTheme())
    }
}
```

### Dynamic Discovery (Plugins)

Plugins are discovered from a directory at runtime:

```
~/Library/Application Support/mclock/Plugins/
├── com.example.pomodoro/
│   ├── plugin.json
│   └── PomodoroPlugin.swift
└── com.example.weather/
    ├── plugin.json
    └── WeatherPlugin.swift
```

## Testing Extensions

Each extension should include unit tests:

```swift
final class SolarizedThemeTests: XCTestCase {
    var sut: SolarizedTheme!

    override func setUp() {
        sut = SolarizedTheme()
    }

    func testName_returnsSolarized() {
        XCTAssertEqual(sut.name, "Solarized")
    }
}
```

## Submitting Extensions

- **Core providers** (auth, themes, lock methods) — Submit as PRs to `mclockCore`
- **Plugins** — Publish independently; add to `examples/` for reference
- **Settings pages** — Submit as PRs or include in plugin bundles

## Related

- [ARCHITECTURE.md](../ARCHITECTURE.md) — System design overview
- [services.md](services.md) — Service API reference
- [plugin-development.md](plugin-development.md) — Plugin authoring guide
- [examples/](../examples/) — Reference implementations
