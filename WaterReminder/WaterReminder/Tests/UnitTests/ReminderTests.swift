//
//  ReminderTests.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import XCTest
import CoreData

class ReminderTests: XCTestCase {
    var viewModel: ReminderViewModel!
    var context: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        let persistentContainer = NSPersistentContainer(name: "WaterReminderApp")
        persistentContainer.loadPersistentStores { _, _ in }
        context = persistentContainer.newBackgroundContext()
        viewModel = ReminderViewModel(context: context)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        context = nil
    }
    
    func testScheduleReminder() throws {
        let now = Date()
        _ = viewModel
            .addReminder(
                time: now.addingTimeInterval(60),
                message: "Test Reminder"
            )
        XCTAssertEqual(viewModel.reminders.count, 1)
        XCTAssertEqual(viewModel.reminders.first?.message, "Test Reminder")
    }
    
    func testAddReminder() throws {
        let now = Date()
        let reminder = viewModel.addReminder(time: now.addingTimeInterval(60), message: "Test Reminder")
        XCTAssertEqual(viewModel.reminders.count, 1)
        XCTAssertEqual(reminder.message, "Test Reminder")
    }

    func testCancelReminder() throws {
        let now = Date()
        let reminder = viewModel.addReminder(time: now.addingTimeInterval(60), message: "Test Reminder")
        viewModel.deleteReminder(reminder: reminder)
        XCTAssertTrue(viewModel.reminders.isEmpty)
    }

    func testToggleReminder() throws {
        let now = Date()
        let reminder = viewModel.addReminder(time: now.addingTimeInterval(60), message: "Test Reminder")
        XCTAssertTrue(reminder.isActive)
        viewModel.toggleReminder(reminder: reminder)
        XCTAssertFalse(reminder.isActive)
    }
}
