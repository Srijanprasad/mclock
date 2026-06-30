import mclockCore
import XCTest

final class MockSettingsService: SettingsServiceProtocol {
    var timeFormat: TimeFormat = .twentyFourHour
}
