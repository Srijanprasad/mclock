# Project State

Last updated: 2026-06-30

This document tracks the current state of the mclock project for contributors and maintainers.

## Current Version

**v0.1.0** (pre-release)

## Project Phase

**Phase 0: Foundation** — Establishing open-source repository infrastructure before application code.

## Status Summary

| Area | Status | Notes |
|------|--------|-------|
| Repository structure | ✅ Complete | Docs, CI, community files |
| Xcode project | ✅ Complete | `mclock.xcodeproj` via XcodeGen |
| Menu bar clock | ✅ Complete | MenuBarExtra with live updates |
| Lock screen | ⬜ Not started | Planned for v0.2.0 |
| Authentication | ⬜ Not started | Planned for v0.3.0 |
| Theming | ⬜ Not started | Planned for v0.4.0 |
| Plugin system | ⬜ Not started | Planned for v0.5.0 |
| CI/CD | ✅ Complete | Build, test, lint, release workflows |
| Documentation | ✅ Complete | All root docs and docs/ structure |
| Tests | ✅ Complete | Unit + UI test scaffolding |

## Active Work

| Branch | Description | Owner | Status |
|--------|-------------|-------|--------|
| — | No active development branches | — | — |

## Known Issues

No known issues — application code has not been implemented yet.

## Technical Debt

| Item | Priority | Target Version |
|------|----------|----------------|
| Implement LockScreenService | High | v0.2.0 |
| Implement AuthenticationService | High | v0.3.0 |
| Add Settings window UI | Medium | v0.4.0 |

## Dependencies

| Dependency | Version | Purpose |
|------------|---------|---------|
| Swift | 5.9+ | Language |
| macOS SDK | 14.0+ | Platform |
| SwiftLint | Latest | Linting |
| SwiftFormat | Latest | Formatting |
| XCTest | Built-in | Testing |

No third-party Swift packages at this time. Dependencies will be documented here as they are added.

## Contributors

See [GitHub Contributors](https://github.com/mclock/mclock/graphs/contributors) for the full list.

## How to Update This Document

When completing significant work:

1. Update the status table
2. Move items from "Active Work" when merged
3. Add new known issues or technical debt items
4. Update "Last updated" date
5. Include the update in your PR

This document is maintained manually and reviewed during release preparation.

## Next Milestone

**v0.1.0 — Foundation**

See [ROADMAP.md](ROADMAP.md) for the full plan.

Key deliverables:
- Xcode project with app, core library, and test targets
- Basic menu bar clock display
- Service protocol definitions
- Initial unit tests
