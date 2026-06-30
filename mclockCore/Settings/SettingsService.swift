import Foundation

/// UserDefaults-backed settings implementation.
public final class SettingsService: SettingsServiceProtocol {
    private enum Keys {
        static let timeFormat = "mclock.settings.timeFormat"
    }

    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public var timeFormat: TimeFormat {
        get {
            guard
                let rawValue = defaults.string(forKey: Keys.timeFormat),
                let format = TimeFormat(rawValue: rawValue)
            else {
                return .twentyFourHour
            }
            return format
        }
        set {
            defaults.set(newValue.rawValue, forKey: Keys.timeFormat)
        }
    }
}
