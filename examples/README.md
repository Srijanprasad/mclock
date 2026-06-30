# mclock Examples

Reference implementations for extending mclock. Each example demonstrates how to implement an extension point protocol without modifying core code.

## Directory Structure

```
examples/
├── authentication/     # AuthenticationProvider examples
├── themes/             # ThemeProvider examples
├── lock-methods/       # LockMethod examples
├── settings/           # SettingsPage examples
├── plugins/            # Plugin examples
└── localization/       # LocalizationProvider examples
```

## How to Use

1. Browse the example closest to what you want to build
2. Copy the pattern into your own implementation
3. Register with the appropriate service at app startup
4. Add tests following the patterns in [CODE_STYLE.md](../CODE_STYLE.md)

## Examples Index

| Example | Extension Point | Description |
|---------|----------------|-------------|
| [TouchIDProvider](authentication/TouchIDProvider.example.swift) | `AuthenticationProvider` | Touch ID unlock |
| [PasswordProvider](authentication/PasswordProvider.example.swift) | `AuthenticationProvider` | Password unlock |
| [DarkTheme](themes/DarkTheme.example.swift) | `ThemeProvider` | Dark color scheme |
| [LightTheme](themes/LightTheme.example.swift) | `ThemeProvider` | Light color scheme |
| [IdleLockMethod](lock-methods/IdleLockMethod.example.swift) | `LockMethod` | Auto-lock on idle |
| [GeneralSettingsPage](settings/GeneralSettingsPage.example.swift) | `SettingsPage` | General preferences UI |
| [PomodoroPlugin](plugins/PomodoroPlugin.example.swift) | `Plugin` | Pomodoro timer integration |
| [EnglishLocalization](localization/EnglishLocalization.example.swift) | `LocalizationProvider` | English strings |

> **Note:** Example files use the `.example.swift` suffix and are not compiled into the app. Copy and adapt them when implementing features.

## Contributing Examples

When adding a new extension point to mclockCore, please add a corresponding example here. Examples should be:

- Self-contained and compilable (when copied into the project)
- Documented with purpose and usage comments
- Minimal — demonstrate the pattern, not a full feature

See [CONTRIBUTING.md](../CONTRIBUTING.md) for submission guidelines.
