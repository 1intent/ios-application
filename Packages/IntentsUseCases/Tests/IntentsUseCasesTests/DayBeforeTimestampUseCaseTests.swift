//
//  DayBeforeTimestampUseCaseTests.swift
//  
//
//  Created by Pierre Abi-aad on 30/05/2024.
//

import IntentsUseCases
import XCTest

final class DayBeforeTimestampUseCaseTests: XCTestCase {

    func testToday() {
        // Given
        let useCase = DayBeforeTimestampUseCaseImpl()
        let reference: DayReference = .today
        let startOfDay = false

        // When
        let timestamp = useCase.execute(reference: reference, startOfDay: startOfDay)
        print(timestamp)
        // Then
        let expectedDate = Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.startOfDay(for: Date()))!
        let expectedTimestamp = expectedDate.timeIntervalSince1970
        XCTAssertEqual(timestamp, expectedTimestamp, accuracy: 1.0)
    }

    func testExecuteTodayStartOfDay() {
        // Given
        let useCase = DayBeforeTimestampUseCaseImpl()
        let reference: DayReference = .today
        let startOfDay = true

        // When
        let timestamp = useCase.execute(reference: reference, startOfDay: startOfDay)

        // Then
        let expectedDate = Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.startOfDay(for: Date()))!
        let expectedTimestamp = expectedDate.timeIntervalSince1970
        XCTAssertEqual(timestamp, expectedTimestamp, accuracy: 1.0)
    }

    func testExecuteTodayEndOfDay() {
        // Given
        let useCase = DayBeforeTimestampUseCaseImpl()
        let reference: DayReference = .today
        let startOfDay = false

        // When
        let timestamp = useCase.execute(reference: reference, startOfDay: startOfDay)

        // Then
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.day! -= 1
        components.hour = 23
        components.minute = 59
        components.second = 59
        components.nanosecond = 999999999

        let expectedDate = Calendar.current.date(from: components)!
        let expectedTimestamp = expectedDate.timeIntervalSince1970
        XCTAssertEqual(timestamp, expectedTimestamp, accuracy: 1.0)
    }

    func testExecuteSpecificDateStartOfDay() {
        // Given
        let useCase = DayBeforeTimestampUseCaseImpl()
        let specificDate = Date(timeIntervalSince1970: 1_660_000_000) // Example specific date
        let reference: DayReference = .specific(specificDate)
        let startOfDay = true

        // When
        let timestamp = useCase.execute(reference: reference, startOfDay: startOfDay)

        // Then
        let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: specificDate)!
        let expectedDate = Calendar.current.startOfDay(for: dayBefore)
        let expectedTimestamp = expectedDate.timeIntervalSince1970
        XCTAssertEqual(timestamp, expectedTimestamp, accuracy: 1.0)
    }

    func testExecuteSpecificDateEndOfDay() {
        // Given
        let useCase = DayBeforeTimestampUseCaseImpl()
        let specificDate = Date(timeIntervalSince1970: 1_660_000_000) // Example specific date
        let reference: DayReference = .specific(specificDate)
        let startOfDay = false

        // When
        let timestamp = useCase.execute(reference: reference, startOfDay: startOfDay)

        // Then
        var components = Calendar.current.dateComponents([.year, .month, .day], from: specificDate)
        components.day! -= 1
        components.hour = 23
        components.minute = 59
        components.second = 59
        components.nanosecond = 999999999

        let dayBefore = Calendar.current.date(from: components)!
        let expectedTimestamp = dayBefore.timeIntervalSince1970
        XCTAssertEqual(timestamp, expectedTimestamp, accuracy: 1.0)
    }
}
