import mclockCore
import XCTest

@MainActor
final class ClockServiceTests: XCTestCase {
    var sut: ClockService!
    var mockSettings: MockSettingsService!

    override func setUp() {
        super.setUp()
        mockSettings = MockSettingsService()
        sut = ClockService(
            settings: mockSettings,
            dateProvider: { Date(timeIntervalSince1970: 0) }
        )
    }

    override func tearDown() {
        sut.stopUpdating()
        sut = nil
        mockSettings = nil
        super.tearDown()
    }

    func testCurrentTime_twentyFourHourFormat_returnsFormattedTime() {
        mockSettings.timeFormat = .twentyFourHour

        sut.startUpdating(every: 1.0)

        XCTAssertFalse(sut.currentTime.isEmpty)
        XCTAssertTrue(sut.isRunning)
    }

    func testCurrentTime_twelveHourFormat_returnsFormattedTime() {
        mockSettings.timeFormat = .twelveHour

        sut.startUpdating(every: 1.0)

        XCTAssertFalse(sut.currentTime.isEmpty)
    }

    func testStopUpdating_stopsTimer() {
        sut.startUpdating(every: 1.0)
        XCTAssertTrue(sut.isRunning)

        sut.stopUpdating()

        XCTAssertFalse(sut.isRunning)
    }

    func testStartUpdating_withZeroInterval_doesNotStart() {
        sut.startUpdating(every: 0)

        XCTAssertFalse(sut.isRunning)
    }
}
