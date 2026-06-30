import XCTest

final class MClockUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppLaunches() throws {
        let app = XCUIApplication()
        app.launch()

        let menuBarItem = app.menuBars.statusItems["mclock"]
        XCTAssertTrue(menuBarItem.waitForExistence(timeout: 5))
    }

    func testMenuBarClockDisplaysTime() throws {
        let app = XCUIApplication()
        app.launch()

        let menuBarItem = app.menuBars.statusItems["mclock"]
        XCTAssertTrue(menuBarItem.waitForExistence(timeout: 5))

        menuBarItem.click()

        let timeFormatMenu = app.menuItems["Time Format"]
        XCTAssertTrue(timeFormatMenu.waitForExistence(timeout: 2))
    }
}
