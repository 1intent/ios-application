//
//  UUIDUseCaseTests.swift
//  
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

import IntentsUseCases
import XCTest

final class UUIDUseCaseTests: XCTestCase {

    func test_get() {
        let useCase = UUIDUseCase()
        XCTAssertFalse(useCase.get().isEmpty)
    }
}
