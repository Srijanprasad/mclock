# mclock

A modular, open-source macOS menu bar clock with extensible lock screen, authentication, and theming support.

[![Build](https://github.com/mclock/mclock/actions/workflows/build.yml/badge.svg)](https://github.com/mclock/mclock/actions/workflows/build.yml)
[![Tests](https://github.com/mclock/mclock/actions/workflows/test.yml/badge.svg)](https://github.com/mclock/mclock/actions/workflows/test.yml)
[![Lint](https://github.com/mclock/mclock/actions/workflows/lint.yml/badge.svg)](https://github.com/mclock/mclock/actions/workflows/lint.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Features

- **Menu bar clock** — Lightweight, always-visible time display in the macOS menu bar
- **Lock screen overlay** — Fullscreen lock overlay to protect your workspace
- **Authentication** — Touch ID and extensible authentication providers
- **Themes** — Customizable appearance without modifying core code
- **Modular architecture** — Add providers, plugins, settings pages, and lock methods via protocols

## Requirements

- macOS 14.0 (Sonoma) or later
- Xcode 15.0 or later
- Swift 5.9+

## Quick Start

### Clone the repository

```bash
git clone https://github.com/mclock/mclock.git
cd mclock
```

### Generate Xcode project (if needed)

```bash
brew install xcodegen
./Scripts/generate-xcodeproj.sh
```

### Build

```bash
xcodebuild -scheme mclock -configuration Debug build
```

### Run tests

```bash
# Unit tests
xcodebuild -scheme mclock -destination 'platform=macOS' test

# UI tests
xcodebuild -scheme mclockUITests -destination 'platform=macOS' test
```

### Lint and format

```bash
swiftlint
swiftformat --lint .
```

## Project Structure

```
mclock/
├── mclock/              # Main application target
├── mclockCore/          # Shared core library (services, protocols)
├── mclockTests/         # Unit tests
├── mclockUITests/       # UI tests
├── docs/                # Extended documentation
├── examples/            # Example plugins, themes, and providers
└── .github/             # Community files and CI workflows
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for a detailed system overview.

## Contributing

We welcome contributions from the community. Please read our guides before opening a pull request:

- [CONTRIBUTING.md](CONTRIBUTING.md) — How to build, test, and submit changes
- [CODE_STYLE.md](CODE_STYLE.md) — Coding conventions and Swift style
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) — Community standards

All changes go through pull requests. Direct commits to `main` are not permitted.

## Documentation

| Document | Description |
|----------|-------------|
| [ARCHITECTURE.md](ARCHITECTURE.md) | System design and module boundaries |
| [ROADMAP.md](ROADMAP.md) | Planned features and milestones |
| [CHANGELOG.md](CHANGELOG.md) | Version history |
| [FAQ.md](FAQ.md) | Frequently asked questions |
| [SECURITY.md](SECURITY.md) | Vulnerability reporting |
| [docs/](docs/) | Extended guides and API reference |

## Versioning

mclock follows [Semantic Versioning](https://semver.org/). See [CHANGELOG.md](CHANGELOG.md) for release notes.

Current version: **v0.1.0**

## License

This project is licensed under the [MIT License](LICENSE).

## Community

- [Report a bug](.github/ISSUE_TEMPLATE/bug_report.yml)
- [Request a feature](.github/ISSUE_TEMPLATE/feature_request.yml)
- [Ask a question](.github/ISSUE_TEMPLATE/question.yml)
