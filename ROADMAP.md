# Roadmap

This document outlines the planned development milestones for mclock. Timelines are approximate and subject to change based on community feedback and contributor availability.

## Vision

Build the most extensible, privacy-respecting macOS menu bar clock with enterprise-grade lock screen capabilities — entirely open source.

---

## v0.1.0 — Foundation (Current)

**Target:** Initial open-source release

- [x] Repository structure and documentation
- [x] CI/CD pipeline (build, test, lint)
- [x] GitHub community files
- [x] Xcode project scaffolding
- [x] Basic menu bar clock display
- [x] App lifecycle and menu bar integration
- [x] Unit test infrastructure

---

## v0.2.0 — Lock Screen

**Target:** Core lock screen functionality

- [ ] Fullscreen lock overlay
- [ ] Lock/unlock state management
- [ ] Keyboard shortcut to lock
- [ ] Auto-lock on idle (configurable timeout)
- [ ] Lock screen UI with clock display
- [ ] UI tests for lock flow

---

## v0.3.0 — Authentication

**Target:** Secure unlock mechanisms

- [ ] Touch ID authentication provider
- [ ] Password authentication provider
- [ ] `AuthenticationProvider` protocol for extensibility
- [ ] Keychain integration for credential storage
- [ ] Authentication failure handling and lockout
- [ ] Unit tests for all auth providers

---

## v0.4.0 — Theming & Settings

**Target:** Customization and user preferences

- [ ] Settings window with modular pages
- [ ] `ThemeProvider` protocol
- [ ] Built-in light and dark themes
- [ ] Clock format customization (12h/24h, date display)
- [ ] `SettingsPage` protocol for extensibility
- [ ] UserDefaults persistence layer

---

## v0.5.0 — Plugin System

**Target:** Third-party extensibility

- [ ] `Plugin` protocol and plugin loader
- [ ] Plugin sandboxing and validation
- [ ] Example plugins in `examples/`
- [ ] Plugin management UI in settings
- [ ] Documentation for plugin authors

---

## v1.0.0 — Stable Release

**Target:** Production-ready, API-stable release

- [ ] API stability guarantee for all public protocols
- [ ] Comprehensive documentation for all public APIs
- [ ] Localization support (`LocalizationProvider`)
- [ ] Performance benchmarks and optimization
- [ ] Signed and notarized `.dmg` release
- [ ] Migration guide from v0.x

---

## Future Considerations (Post v1.0)

These are ideas under consideration but not yet scheduled:

- **Multi-monitor support** — Lock screen across all displays
- **Scheduled lock** — Lock at specific times
- **Focus modes integration** — Tie into macOS Focus
- **Widgets** — Notification Center widgets
- **iCloud sync** — Settings sync across devices
- **Homebrew cask** — `brew install --cask mclock`

---

## How to Influence the Roadmap

- Open a [Feature Request](.github/ISSUE_TEMPLATE/feature_request.yml)
- Comment on existing issues with 👍 reactions
- Join discussions in pull requests
- Contribute code for roadmap items

Priority is given to features with community demand and active contributors.
