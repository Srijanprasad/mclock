import mclockCore
import XCTest

@MainActor
final class ServiceContainerTests: XCTestCase {
    func testInit_createsDefaultServices() {
        let container = ServiceContainer()

        XCTAssertNotNil(container.settings)
        XCTAssertNotNil(container.clockService)
    }

    func testStartServices_startsClockUpdates() {
        let container = ServiceContainer()

        container.startServices()

        XCTAssertTrue(container.clockService.isRunning)

        container.stopServices()
    }
}
