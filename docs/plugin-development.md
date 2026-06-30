# Plugin Development Guide

This guide explains how to create plugins for mclock.

## Overview

Plugins are self-contained extensions that add functionality to mclock at runtime. They implement the `Plugin` protocol and are loaded from the plugins directory.

## Plugin Structure

```
MyPlugin/
├── plugin.json          # Manifest
├── Package.swift        # Swift package (optional)
└── Sources/
    └── MyPlugin/
        └── MyPlugin.swift
```

## Plugin Manifest

Every plugin requires a `plugin.json` manifest:

```json
{
  "id": "com.example.myplugin",
  "name": "My Plugin",
  "version": "1.0.0",
  "author": "Your Name",
  "description": "A brief description of what this plugin does.",
  "minimumMClockVersion": "0.5.0",
  "permissions": ["clock", "settings"],
  "main": "MyPlugin"
}
```

### Permissions

Plugins must declare which services they access:

| Permission | Access |
|------------|--------|
| `clock` | Read/update clock display |
| `settings` | Read/write user settings |
| `lockScreen` | Trigger lock/unlock |
| `authentication` | Register auth providers |
| `theme` | Register themes |
| `notifications` | Show user notifications |

## Implementing a Plugin

```swift
import mclockCore

public struct MyPlugin: Plugin {
    public var id: String { "com.example.myplugin" }
    public var name: String { "My Plugin" }
    public var version: String { "1.0.0" }

    private var timer: Timer?

    public func activate(in context: PluginContext) {
        // Called when the plugin is loaded
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            // Do something every minute
        }
    }

    public func deactivate() {
        // Called when the plugin is unloaded — clean up resources
        timer?.invalidate()
        timer = nil
    }
}
```

## PluginContext

The `PluginContext` provides access to core services:

```swift
public struct PluginContext {
    public let clockService: ClockServiceProtocol
    public let settingsService: SettingsServiceProtocol
    public let lockScreenService: LockScreenServiceProtocol
    public let themeService: ThemeServiceProtocol
    public let notificationService: NotificationServiceProtocol
}
```

Only access services declared in your plugin's permissions.

## Installation

Users install plugins by placing them in:

```
~/Library/Application Support/mclock/Plugins/
```

Or via the Plugin Manager in Settings (v0.5.0+).

## Testing Plugins

```swift
final class MyPluginTests: XCTestCase {
    var sut: MyPlugin!
    var mockContext: MockPluginContext!

    override func setUp() {
        mockContext = MockPluginContext()
        sut = MyPlugin()
    }

    func testActivate_startsTimer() {
        sut.activate(in: mockContext)
        // Verify expected behavior
    }

    func testDeactivate_stopsTimer() {
        sut.activate(in: mockContext)
        sut.deactivate()
        // Verify cleanup
    }
}
```

## Publishing

1. Test your plugin thoroughly
2. Add it to `examples/plugins/` as a reference (optional)
3. Publish to your own repository
4. Share the link in GitHub Discussions

## Security

- Plugins run with the same permissions as mclock
- Validate all external input
- Do not access the network without declaring it
- Do not store credentials outside Keychain
- Report security issues via [SECURITY.md](../SECURITY.md)

## Example Plugins

See [examples/plugins/](../examples/plugins/) for reference implementations:

- **Pomodoro Timer** — Clock integration example
- **Weather Display** — Settings page example

## Related

- [extensibility.md](extensibility.md) — All extension points
- [services.md](services.md) — Service API reference
- [ARCHITECTURE.md](../ARCHITECTURE.md) — System design
