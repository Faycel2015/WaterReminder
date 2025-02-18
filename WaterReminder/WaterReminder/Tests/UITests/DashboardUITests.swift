//
//  DashboardUITests.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import XCTest

class DashboardUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testMainDashboard() throws {
        let app = XCUIApplication()

        // Verify dashboard elements
        XCTAssertTrue(app.staticTexts["Stay Hydrated"].exists)
        XCTAssertTrue(app.buttons["250 ml"].exists)
        XCTAssertTrue(app.buttons["500 ml"].exists)
        XCTAssertTrue(app.buttons["750 ml"].exists)

        // Test quick-add button
        app.buttons["250 ml"].tap()
        XCTAssertTrue(app.staticTexts["250 ml"].exists)
    }

    func testNotificationPermissionRequest() throws {
        let app = XCUIApplication()

        // Simulate notification permission request
        let alert = app.alerts["Allow Notifications"]
        XCTAssertTrue(alert.exists)
        alert.buttons["Allow"].tap()
    }
}
