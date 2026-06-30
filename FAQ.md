# Frequently Asked Questions

## General

### What is mclock?

mclock is an open-source macOS menu bar clock application with lock screen capabilities. It displays the current time in your menu bar and can lock your screen with a fullscreen overlay, supporting Touch ID and other authentication methods.

### Is mclock free?

Yes. mclock is open source under the [MIT License](LICENSE) and free to use, modify, and distribute.

### What macOS versions are supported?

macOS 14.0 (Sonoma) and later. See [README.md](README.md#requirements) for details.

### Does mclock collect any data?

No. mclock is privacy-first. It does not collect, transmit, or store any user data outside your local machine. Settings are stored in UserDefaults; credentials are stored in the Keychain.

---

## Installation & Usage

### How do I install mclock?

Currently, mclock must be built from source. See the [README](README.md#quick-start) for build instructions. Pre-built releases will be available starting with v1.0.0.

### How do I lock my screen with mclock?

Once implemented (v0.2.0), you will be able to lock via:
- Menu bar item → Lock
- Configurable keyboard shortcut
- Auto-lock on idle

### Can I customize the clock appearance?

Yes (planned for v0.4.0). mclock supports themes via the `ThemeProvider` protocol. Built-in light and dark themes will be included, and you can create custom themes. See [examples/themes/](examples/themes/).

---

## Development

### How do I contribute?

Read [CONTRIBUTING.md](CONTRIBUTING.md) for the full guide. In short:

1. Fork the repository
2. Create a feature branch
3. Make your changes with tests
4. Submit a pull request

### What branch should I base my work on?

Always branch from the latest `main`. Use the branch naming conventions in [CONTRIBUTING.md](CONTRIBUTING.md#branch-naming).

### Do I need to sign a CLA?

No. mclock does not require a Contributor License Agreement. By contributing, you agree that your contributions are licensed under the MIT License.

### How do I run tests locally?

```bash
xcodebuild -scheme mclock -destination 'platform=macOS' test
```

See [CONTRIBUTING.md](CONTRIBUTING.md#running-tests) for more details.

### Why does CI fail on my PR?

Common reasons:
- SwiftLint violations — run `swiftlint` locally
- Formatting issues — run `swiftformat .` locally
- Missing tests — add tests for new behavior
- Build warnings — fix all warnings before submitting

---

## Architecture

### How is mclock structured?

mclock uses a modular architecture with a core library (`mclockCore`) and an app target (`mclock`). See [ARCHITECTURE.md](ARCHITECTURE.md) for details.

### How do I add a new authentication method?

Implement the `AuthenticationProvider` protocol and register it with `AuthenticationService`. See [docs/extensibility.md](docs/extensibility.md) and [examples/authentication/](examples/authentication/).

### How do I create a plugin?

Implement the `Plugin` protocol and place it in the plugins directory. See [docs/extensibility.md](docs/extensibility.md) and [examples/plugins/](examples/plugins/).

### Can I add a new settings page?

Yes. Implement the `SettingsPage` protocol. Settings pages are automatically discovered and rendered. See [examples/settings/](examples/settings/).

---

## Releases

### How often are releases made?

Releases follow the [ROADMAP.md](ROADMAP.md) milestones. Patch releases (bug fixes) are made as needed between milestones.

### How does versioning work?

We follow [Semantic Versioning](https://semver.org/):
- **Major** (v2.0.0) — Breaking API changes
- **Minor** (v1.1.0) — New features, backward compatible
- **Patch** (v1.0.1) — Bug fixes, backward compatible

### Where can I find release notes?

In [CHANGELOG.md](CHANGELOG.md) and on [GitHub Releases](https://github.com/mclock/mclock/releases).

---

## Security

### How do I report a security vulnerability?

Email **security@mclock.dev**. Do not open a public issue. See [SECURITY.md](SECURITY.md) for details.

### Is Touch ID data stored by mclock?

No. Touch ID authentication is handled entirely by Apple's LocalAuthentication framework. mclock never accesses biometric data.

---

## Community

### Where can I ask questions not covered here?

- Open a [Question issue](.github/ISSUE_TEMPLATE/question.yml)
- Start a [GitHub Discussion](https://github.com/mclock/mclock/discussions) (when enabled)

### How do I request a feature?

Open a [Feature Request issue](.github/ISSUE_TEMPLATE/feature_request.yml) with a clear description of the use case.

### Is there a code of conduct?

Yes. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
