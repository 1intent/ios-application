//
//  TimeIntervalSinceUseCaseTests.swift
//
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

import IntentsUseCases
import XCTest

final class TimeIntervalSinceUseCaseTests: XCTestCase {

    func test_invoke_1970() {
        let date = Date(timeIntervalSince1970: 1)
        let useCase = TimeIntervalSinceUseCase()

        XCTAssertEqual(useCase.invoke(with: date, option: .year1970), 1)
    }

    func test_invoke_referenceDate() {
        let date = Date(timeIntervalSinceReferenceDate: 1)
        let useCase = TimeIntervalSinceUseCase()

        XCTAssertEqual(useCase.invoke(with: date, option: .referenceDate), 1)
    }

    func test_invoke_date() {
        let date1 = Date(timeIntervalSince1970: 3)
        let date2 = Date(timeIntervalSince1970: 1)
        let useCase = TimeIntervalSinceUseCase()

        XCTAssertEqual(useCase.invoke(with: date1, option: .date(date2)), 2)
    }
}
