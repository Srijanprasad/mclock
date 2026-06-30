# Code Style Guide

This document defines coding conventions for mclock. All contributors must follow these guidelines. CI enforces many of these automatically via SwiftLint and SwiftFormat.

## Swift Style

We follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) and [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).

### Naming

```swift
// Types: UpperCamelCase
struct ClockConfiguration { }
protocol AuthenticationProvider { }
enum LockState { }

// Properties, methods, variables: lowerCamelCase
var currentTime: String
func startUpdating(every interval: TimeInterval)

// Constants: lowerCamelCase (not SCREAMING_SNAKE)
let defaultUpdateInterval: TimeInterval = 1.0

// Protocol names: describe capability (-able, -ible, or noun)
protocol ThemeProvider { }
protocol LockScreenServiceProtocol { }
```

### File Organization

- One primary type per file
- File name matches the primary type: `ClockService.swift`
- Extensions in separate files: `ClockService+Formatting.swift`
- Group files by feature module, not by type

### Access Control

- Default to `internal` — only expose what is needed
- Mark public APIs with `public` and document them
- Use `private` for implementation details
- Prefer `fileprivate` over `private` only when needed for extensions in the same file

### Protocols

- Define protocols in dedicated files
- Suffix service protocols with `Protocol`: `ClockServiceProtocol`
- Extension point protocols use descriptive names: `AuthenticationProvider`, `ThemeProvider`

```swift
/// Authenticates the user to unlock the lock screen.
protocol AuthenticationProvider {
    /// Human-readable name shown in settings (e.g., "Touch ID").
    var displayName: String { get }

    /// Whether this provider is available on the current device.
    var isAvailable: Bool { get }

    /// Attempt authentication. Returns `true` on success.
    func authenticate() async throws -> Bool
}
```

### Documentation

Every public API must have documentation comments:

```swift
/// Formats and publishes time updates for the menu bar display.
///
/// - Important: Call `stopUpdating()` when the service is no longer needed
///   to prevent timer leaks.
///
/// ## Example
/// ```swift
/// let clock = ClockService(settings: settingsService)
/// clock.startUpdating(every: 1.0)
/// print(clock.currentTime) // "14:30"
/// ```
public final class ClockService: ClockServiceProtocol {
    /// The formatted current time string.
    public var currentTime: String { ... }
}
```

Service documentation must include:
- **Purpose** — What the service does (one line)
- **Responsibilities** — Bullet list of what it manages
- **Dependencies** — What it depends on
- **Example Usage** — Code snippet

### Error Handling

- Define typed errors as enums conforming to `Error` and `LocalizedError`
- Use `throws` for recoverable errors
- Use `Result` types at protocol boundaries when appropriate
- Never force-unwrap (`!`) in production code
- Use `guard` for early returns

```swift
enum AuthenticationError: Error, LocalizedError {
    case biometricsNotAvailable
    case authenticationFailed
    case userCancelled

    var errorDescription: String? {
        switch self {
        case .biometricsNotAvailable: "Biometric authentication is not available."
        case .authenticationFailed: "Authentication failed."
        case .userCancelled: "Authentication was cancelled."
        }
    }
}
```

### Concurrency

- Use `async/await` for asynchronous operations
- Mark UI-related classes with `@MainActor`
- Use `Task` for fire-and-forget async work
- Prefer structured concurrency (`async let`, task groups) over unstructured tasks

### SwiftUI

- Keep views small and focused
- Extract subviews when body exceeds ~30 lines
- Use `@StateObject` for owned observable objects
- Use `@ObservedObject` for injected observable objects
- Prefer `@Environment` for shared dependencies

```swift
struct LockOverlayView: View {
    @ObservedObject var viewModel: LockScreenViewModel

    var body: some View {
        ZStack {
            background
            clockDisplay
            authenticationPrompt
        }
    }

    private var background: some View { ... }
    private var clockDisplay: some View { ... }
    private var authenticationPrompt: some View { ... }
}
```

## Formatting

SwiftFormat handles formatting automatically. Key rules:

| Rule | Setting |
|------|---------|
| Indentation | 4 spaces (no tabs) |
| Line length | 120 characters max |
| Brace style | K&R (same line) |
| Trailing commas | Enabled in multi-line collections |
| Self removal | Remove redundant `self.` |

Run before committing:

```bash
swiftformat .
swiftformat --lint .  # Check without modifying
```

## Linting

SwiftLint enforces style rules. Configuration is in `.swiftlint.yml`.

Key rules:
- No force unwrapping
- No force casting
- Line length ≤ 120
- Function body length ≤ 50 lines
- Type body length ≤ 300 lines
- Cyclomatic complexity ≤ 10

Run before committing:

```bash
swiftlint
swiftlint --strict  # Treat warnings as errors
```

## Testing Conventions

### Unit Tests

```swift
final class ClockServiceTests: XCTestCase {
    var sut: ClockService!
    var mockSettings: MockSettingsService!

    override func setUp() {
        super.setUp()
        mockSettings = MockSettingsService()
        sut = ClockService(settings: mockSettings)
    }

    override func tearDown() {
        sut = nil
        mockSettings = nil
        super.tearDown()
    }

    func testCurrentTime_returnsFormattedTime() {
        // Given
        mockSettings.timeFormat = .twentyFourHour

        // When
        let time = sut.currentTime

        // Then
        XCTAssertFalse(time.isEmpty)
    }
}
```

- Use Given/When/Then structure
- Name tests: `test<Method>_<Condition>_<ExpectedResult>`
- One assertion concept per test
- Use mocks for dependencies (prefix with `Mock`)
- System Under Test variable named `sut`

### UI Tests

```swift
final class LockScreenUITests: XCTestCase {
    func testLockScreen_displaysClockWhenLocked() {
        let app = XCUIApplication()
        app.launch()

        app.menuBars.buttons["mclock"].click()
        app.menuItems["Lock"].click()

        XCTAssertTrue(app.windows["LockOverlay"].exists)
    }
}
```

## Git Conventions

See [CONTRIBUTING.md](CONTRIBUTING.md) for branch naming and commit message conventions.

## Code Review Checklist

Reviewers should verify:

- [ ] Follows naming conventions
- [ ] Public APIs documented
- [ ] No force unwraps or force casts
- [ ] Tests included for new behavior
- [ ] SwiftLint and SwiftFormat pass
- [ ] No warnings introduced
- [ ] Extensibility via protocols (not hard-coded logic)
