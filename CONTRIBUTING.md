# Contributing to mclock

Thank you for your interest in contributing to mclock. This project is designed to be community-driven and contributor-friendly. Every change goes through a pull request — there are no direct commits to `main`.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Building the Project](#building-the-project)
- [Running Tests](#running-tests)
- [Code Quality](#code-quality)
- [Coding Conventions](#coding-conventions)
- [Commit Messages](#commit-messages)
- [Pull Requests](#pull-requests)
- [Code Review](#code-review)
- [Release Process](#release-process)
- [Extensibility Guidelines](#extensibility-guidelines)

## Code of Conduct

All contributors must follow our [Code of Conduct](CODE_OF_CONDUCT.md). Be respectful, inclusive, and constructive.

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally:

   ```bash
   git clone https://github.com/YOUR_USERNAME/mclock.git
   cd mclock
   ```

3. Add the upstream remote:

   ```bash
   git remote add upstream https://github.com/mclock/mclock.git
   ```

4. Create a feature branch (see [Development Workflow](#development-workflow))

## Development Workflow

We use **GitHub Flow**. All work happens on branches and merges via pull request.

### Branch Naming

| Prefix | Purpose | Example |
|--------|---------|---------|
| `feature/` | New features | `feature/touch-id-auth` |
| `fix/` | Bug fixes | `fix/menu-bar-duplicate-icon` |
| `docs/` | Documentation only | `docs/installation-guide` |
| `release/` | Release preparation | `release/v0.2.0` |
| `hotfix/` | Urgent production fixes | `hotfix/crash-on-launch` |

### Typical Workflow

```bash
# Sync with upstream
git fetch upstream
git checkout main
git merge upstream/main

# Create your branch
git checkout -b feature/my-feature

# Make changes, commit, push
git push -u origin feature/my-feature

# Open a Pull Request on GitHub
```

## Building the Project

### Prerequisites

- macOS 14.0+
- Xcode 15.0+
- [SwiftLint](https://github.com/realm/SwiftLint) (`brew install swiftlint`)
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) (`brew install swiftformat`)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`) — only needed to regenerate `mclock.xcodeproj`

### Build Commands

```bash
# Debug build
xcodebuild -scheme mclock -configuration Debug build

# Release build
xcodebuild -scheme mclock -configuration Release build
```

## Running Tests

Every pull request must pass all tests with zero warnings.

```bash
# Unit tests
xcodebuild -scheme mclock \
  -destination 'platform=macOS' \
  -only-testing:mclockTests \
  test

# UI tests
xcodebuild -scheme mclock \
  -destination 'platform=macOS' \
  -only-testing:mclockUITests \
  test

# All tests
xcodebuild -scheme mclock -destination 'platform=macOS' test
```

## Code Quality

All pull requests must pass the following checks (enforced by CI):

| Check | Tool | Command |
|-------|------|---------|
| Lint | SwiftLint | `swiftlint` |
| Format | SwiftFormat | `swiftformat --lint .` |
| Build | xcodebuild | See [Building](#building-the-project) |
| Unit Tests | XCTest | See [Running Tests](#running-tests) |
| UI Tests | XCUITest | See [Running Tests](#running-tests) |
| Warnings | xcodebuild | Zero warnings required |

Run all checks locally before pushing:

```bash
swiftlint && swiftformat --lint . && xcodebuild -scheme mclock -destination 'platform=macOS' test
```

## Coding Conventions

See [CODE_STYLE.md](CODE_STYLE.md) for detailed conventions. Key points:

- Follow Swift API Design Guidelines
- Document all public APIs with `///` doc comments
- Keep modules focused and loosely coupled
- Prefer protocol-oriented design for extensibility
- Match existing patterns in the codebase

## Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Purpose |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `test` | Adding or updating tests |
| `ci` | CI/CD changes |
| `chore` | Maintenance tasks |

### Examples

```
feat(authentication): add Touch ID support
feat(lock-screen): implement fullscreen overlay
fix(menu-bar): resolve duplicate icon issue
docs(readme): improve installation guide
refactor(monitor): simplify app launch observer
test(authentication): add unit tests
ci(actions): add macOS build workflow
```

## Pull Requests

1. Fill out the [pull request template](.github/PULL_REQUEST_TEMPLATE.md) completely
2. Link related issues using `Closes #123` or `Fixes #456`
3. Include screenshots for UI changes
4. Ensure all CI checks pass
5. Request review from relevant code owners (see [CODEOWNERS](.github/CODEOWNERS))

### PR Checklist

- [ ] Branch is up to date with `main`
- [ ] All CI checks pass
- [ ] Tests added/updated for new behavior
- [ ] Documentation updated
- [ ] CHANGELOG updated (for user-facing changes)
- [ ] No warnings introduced
- [ ] Public APIs documented

## Code Review

### Expectations for Authors

- Respond to feedback promptly and respectfully
- Keep PRs focused and reasonably sized
- Split large changes into smaller, reviewable PRs
- Explain non-obvious decisions in the PR description

### Expectations for Reviewers

- Review within 3 business days when possible
- Be constructive and specific
- Approve when the change meets quality standards
- Request changes with clear, actionable feedback

### Approval Requirements

- At least one approval from a code owner
- All CI checks green
- No unresolved review comments

## Release Process

Releases are managed via GitHub Releases and automated by CI. See [docs/release-process.md](docs/release-process.md) for details.

1. Merge features into `main` via PR
2. Create a `release/vX.Y.Z` branch when ready
3. CI generates version, changelog, and release artifacts
4. Tag is created and GitHub Release is published with:
   - Release notes
   - Binary (`.dmg`)
   - Source code archive
   - Changelog excerpt
   - Migration notes (if applicable)

## Extensibility Guidelines

mclock is designed so contributors can extend functionality without modifying existing code:

| Extension Point | Protocol | Location |
|-----------------|----------|----------|
| Authentication providers | `AuthenticationProvider` | `mclockCore/Authentication/` |
| Themes | `ThemeProvider` | `mclockCore/Theming/` |
| Lock methods | `LockMethod` | `mclockCore/LockScreen/` |
| Settings pages | `SettingsPage` | `mclockCore/Settings/` |
| Plugins | `Plugin` | `mclockCore/Plugins/` |
| Languages | `LocalizationProvider` | `mclockCore/Localization/` |

See [docs/extensibility.md](docs/extensibility.md) and [examples/](examples/) for implementation guides.

## Questions?

- Check the [FAQ](FAQ.md)
- Open a [Question issue](.github/ISSUE_TEMPLATE/question.yml)
- Read [ARCHITECTURE.md](ARCHITECTURE.md) for system design

Thank you for contributing to mclock!
