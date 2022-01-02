//
//  URLQueryUseCaseTests.swift
//  
//
//  Created by Pierre Abi-aad on 02/01/2022.
//

import IntentsUseCases
import XCTest

final class URLQueryUseCaseTests: XCTestCase {

    func test_success() throws {
        let useCase = URLQueryUseCase()

        let query =  try useCase.invoke(keys: ["key1", "key2"], values: ["value1", "value2"])
        XCTAssertEqual(query, "key1=value1&key2=value2")
    }

    func test_error_emptyArray() {
        let useCase = URLQueryUseCase()
        do {
            let _ = try useCase.invoke(keys: [], values: [])
        } catch {
            XCTAssertEqual(error as? URLQueryUseCaseError, URLQueryUseCaseError.emptyArray)
        }
    }

    func test_error_countMismatch() {
        let useCase = URLQueryUseCase()
        do {
            let _ = try useCase.invoke(keys: [""], values: ["", ""])
        } catch {
            XCTAssertEqual(error as? URLQueryUseCaseError, URLQueryUseCaseError.countMismatch)
        }
    }
}
