//
//  WaterIntakeTests.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import XCTest
@testable import WaterReminder
import CoreData

class WaterIntakeTests: XCTestCase {
    var viewModel: WaterIntakeViewModel!
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        let persistentContainer = NSPersistentContainer(name: "WaterReminderApp")
        persistentContainer.loadPersistentStores { _, _ in }
        context = persistentContainer.newBackgroundContext()
        viewModel = WaterIntakeViewModel(context: context)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        context = nil
    }

    func testAddWater() throws {
        // Add water intake
        viewModel.addWater(amount: 500, unit: "ml")
        XCTAssertTrue(viewModel.totalIntake == 500)
        XCTAssertTrue(viewModel.progress == 0.25) // Assuming daily goal is 2000 ml
    }

    func testFetchWaterIntakes() throws {
        // Add multiple water intakes
        viewModel.addWater(amount: 250, unit: "ml")
        viewModel.addWater(amount: 750, unit: "ml")

        // Fetch and validate
        XCTAssertTrue(viewModel.waterIntakes.count == 2)
        XCTAssertTrue(viewModel.totalIntake == 1000)
    }

    func testDailyIntakeAggregation() throws {
        // Add water intake for today
        viewModel.addWater(amount: 300, unit: "ml")

        // Validate daily intake
        let today = Date()
        XCTAssertTrue(viewModel.getDailyIntake(for: today) == 300)
    }
}
