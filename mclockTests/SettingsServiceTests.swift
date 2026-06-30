import mclockCore
import XCTest

final class SettingsServiceTests: XCTestCase {
    var sut: SettingsService!
    var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: "mclock.tests.settings")!
        defaults.removePersistentDomain(forName: "mclock.tests.settings")
        sut = SettingsService(defaults: defaults)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: "mclock.tests.settings")
        sut = nil
        defaults = nil
        super.tearDown()
    }

    func testTimeFormat_defaultValue_isTwentyFourHour() {
        XCTAssertEqual(sut.timeFormat, .twentyFourHour)
    }

    func testTimeFormat_setValue_persistsValue() {
        sut.timeFormat = .twelveHour

        let restored = SettingsService(defaults: defaults)
        XCTAssertEqual(restored.timeFormat, .twelveHour)
    }
}
