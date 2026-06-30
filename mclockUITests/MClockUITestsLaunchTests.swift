import XCTest

final class MClockUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let menuBarItem = app.menuBars.statusItems["mclock"]
        XCTAssertTrue(menuBarItem.waitForExistence(timeout: 5))
    }
}
