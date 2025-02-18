//
//  ReminderUITests.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import XCTest
import SwiftUI

class ReminderUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testReminderConfiguration() throws {
        let app = XCUIApplication()

        // Navigate to Reminder Configuration
        app.tabBars.buttons["Settings"].tap()
        app.staticTexts["Reminder Configuration"].tap()

        // Add a new reminder
        app.buttons["Add Reminder"].tap()
        app.datePickers.firstMatch.adjust(toPickerWheelValue: "8:00 AM")
        app.textFields["Message"].typeText("Drink Water!")
        app.buttons["Save Reminder"].tap()

        // Verify reminder is added
        XCTAssertTrue(app.tables.staticTexts["8:00 AM"].exists)
        XCTAssertTrue(app.tables.staticTexts["Drink Water!"].exists)
    }

    func testEditReminder() throws {
        let app = XCUIApplication()

        // Navigate to Reminder Configuration
        app.tabBars.buttons["Settings"].tap()
        app.staticTexts["Reminder Configuration"].tap()

        // Toggle an existing reminder
        app.tables.switches.element(boundBy: 0).tap()

        // Delete a reminder
        app.tables.cells.element(boundBy: 0).swipeLeft()
        app.tables.buttons["Delete"].tap()
        XCTAssertTrue(app.tables.cells.count == 0)
    }
}
