# Getting Started

This guide walks you through setting up your mclock development environment.

## Prerequisites

Install the following before you begin:

| Tool | Version | Install |
|------|---------|---------|
| macOS | 14.0+ | — |
| Xcode | 15.0+ | [Mac App Store](https://apps.apple.com/app/xcode/id497799835) |
| SwiftLint | Latest | `brew install swiftlint` |
| SwiftFormat | Latest | `brew install swiftformat` |
| XcodeGen | Latest | `brew install xcodegen` |
| Git | 2.30+ | `xcode-select --install` |

Optional but recommended:

```bash
brew install xcpretty    # Prettier xcodebuild output
```

## Clone and Setup

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/mclock.git
cd mclock

# Add upstream remote
git remote add upstream https://github.com/mclock/mclock.git

# Verify tools
xcodebuild -version
swiftlint version
swiftformat --version
```

## Opening the Project

```bash
open mclock.xcodeproj
```

If `mclock.xcodeproj` is missing or you changed `project.yml`:

```bash
brew install xcodegen   # one-time setup
./Scripts/generate-xcodeproj.sh
open mclock.xcodeproj
```

Select the **mclock** scheme and **My Mac** as the destination.

## Building

```bash
# Debug build (development)
xcodebuild -scheme mclock -configuration Debug build

# Release build
xcodebuild -scheme mclock -configuration Release build
```

Or press `Cmd+B` in Xcode.

## Running

Press `Cmd+R` in Xcode, or:

```bash
xcodebuild -scheme mclock -configuration Debug build
open build/Debug/mclock.app
```

The app appears in your menu bar.

## Running Tests

```bash
# All tests
xcodebuild -scheme mclock -destination 'platform=macOS' test

# Unit tests only
xcodebuild -scheme mclock \
  -destination 'platform=macOS' \
  -only-testing:mclockTests test

# UI tests only
xcodebuild -scheme mclock \
  -destination 'platform=macOS' \
  -only-testing:mclockUITests test
```

In Xcode: `Cmd+U` runs all tests.

## Code Quality Checks

Run before every commit:

```bash
# Lint
swiftlint

# Format (modifies files)
swiftformat .

# Format check (no modifications)
swiftformat --lint .

# All checks
swiftlint && swiftformat --lint .
```

## Creating a Feature Branch

```bash
git fetch upstream
git checkout main
git merge upstream/main
git checkout -b feature/my-feature
```

See [CONTRIBUTING.md](../CONTRIBUTING.md) for branch naming conventions.

## Project Structure

```
mclock/
├── mclock/              # App target — UI, menu bar, app lifecycle
├── mclockCore/          # Core library — services, protocols, business logic
├── mclockTests/         # Unit tests
├── mclockUITests/       # UI tests
├── docs/                # This documentation
├── examples/            # Example providers, themes, plugins
└── .github/             # CI/CD and community files
```

## Troubleshooting

### Xcode project not found

Regenerate it from `project.yml`:

```bash
brew install xcodegen
./Scripts/generate-xcodeproj.sh
```

### SwiftLint not found

```bash
brew install swiftlint
```

### Build fails with signing errors

For local development, disable code signing:

```bash
xcodebuild build -scheme mclock CODE_SIGNING_ALLOWED=NO
```

### Tests fail on CI but pass locally

Ensure you're running on macOS 14+ with Xcode 15+. CI uses `macos-14` runners with Xcode 15.4.

## Next Steps

- Read [ARCHITECTURE.md](../ARCHITECTURE.md) to understand the system design
- Read [extensibility.md](extensibility.md) to learn how to add features
- Browse [examples/](../examples/) for reference implementations
- Pick an issue labeled [`good first issue`](https://github.com/mclock/mclock/labels/good%20first%20issue)
