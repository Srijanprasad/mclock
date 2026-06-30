# Release Process

This document describes how mclock releases are created, published, and maintained.

## Overview

Releases follow [Semantic Versioning](https://semver.org/) and are automated via GitHub Actions. Each release includes release notes, a binary, source code, and changelog updates.

## Version Numbering

| Change Type | Version Bump | Example |
|-------------|-------------|---------|
| Breaking API change | Major | v1.0.0 → v2.0.0 |
| New feature (backward compatible) | Minor | v1.0.0 → v1.1.0 |
| Bug fix (backward compatible) | Patch | v1.0.0 → v1.0.1 |
| Pre-release | Suffix | v1.0.0-rc.1 |

## Release Workflow

### 1. Prepare

Ensure all features for the milestone are merged to `main` via PR:

- All CI checks pass
- CHANGELOG.md updated under `[Unreleased]`
- PROJECT_STATE.md reflects current status
- ROADMAP.md milestone items checked off

### 2. Create Release Branch (Optional)

For larger releases, create a stabilization branch:

```bash
git checkout -b release/v0.2.0 main
# Fix any last-minute issues via PR to release branch
```

### 3. Tag and Release

**Automatic (recommended):**

Push a semver tag to trigger the release workflow:

```bash
git tag v0.2.0
git push origin v0.2.0
```

**Manual dispatch:**

Go to Actions → Release → Run workflow, enter the version (e.g., `v0.2.0`).

### 4. What CI Does

The [release workflow](../.github/workflows/release.yml) automatically:

1. Validates the version format (vX.Y.Z)
2. Builds the Release configuration
3. Runs all unit and UI tests
4. Generates changelog from CHANGELOG.md or git log
5. Creates a GitHub Release with:
   - Release notes
   - Binary (`.zip` of the app)
   - Source code archive (automatic)
6. Updates CHANGELOG.md with the version header

### 5. Post-Release

- Verify the GitHub Release page
- Test the downloaded binary
- Update PROJECT_STATE.md with the new version
- Announce if it's a significant release

## Changelog Management

### During Development

Add entries to `CHANGELOG.md` under `[Unreleased]` as you merge PRs:

```markdown
## [Unreleased]

### Added
- Touch ID authentication provider

### Fixed
- Menu bar icon duplication on wake from sleep
```

### At Release Time

The release workflow moves `[Unreleased]` entries under the version header:

```markdown
## [Unreleased]

---

## v0.2.0

### Added
- Touch ID authentication provider
```

### Categories

Use these categories (in order):

- **Added** — New features
- **Changed** — Changes to existing functionality
- **Fixed** — Bug fixes
- **Removed** — Removed features
- **Security** — Security fixes

## Hotfix Releases

For critical bugs in a released version:

```bash
git checkout -b hotfix/critical-crash v1.0.0
# Fix the bug via PR
git tag v1.0.1
git push origin v1.0.1
```

Hotfix branches are merged back to `main`.

## Pre-Releases

For beta/RC releases:

```bash
git tag v1.0.0-rc.1
git push origin v1.0.0-rc.1
```

Pre-releases are marked as such on GitHub (v0.x.x versions are automatically marked pre-release).

## Migration Notes

When a release includes breaking changes:

1. Add a `### Migration` section to the CHANGELOG entry
2. Include step-by-step migration instructions
3. Reference the migration guide in the GitHub Release body

Example:

```markdown
## v2.0.0

### Changed
- Renamed `AuthenticationProvider.authenticate()` to `authenticate() async throws`

### Migration
- Update all `AuthenticationProvider` implementations to use async/await
- See [docs/migration/v2.0.0.md](migration/v2.0.0.md) for details
```

## Release Checklist

- [ ] All milestone issues closed or deferred
- [ ] CHANGELOG.md updated
- [ ] All CI checks green on `main`
- [ ] Version tag created and pushed
- [ ] GitHub Release verified (notes, binary, source)
- [ ] PROJECT_STATE.md updated
- [ ] ROADMAP.md milestone marked complete
