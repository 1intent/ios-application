//
//  UUIDIntentHandlerTests.swift
//  UnitTests
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

//import Intents
//import IntentsUseCases
//import XCTest
//@testable import IntentsExtension

// TODO: fix compilation
//final class UUIDIntentHandlerTests: XCTestCase {
//
//    func test() async {
//        //GIVEN
//        let useCaseMock = UUIDUseCaseMock()
//        let expectation = self.expectation(description: "_get")
//        useCaseMock._get = {
//            expectation.fulfill()
//            return "some uuid"
//        }
//        let handler = UUIDIntentHandler(useCase: useCaseMock)
//
//        //WHEN
//        let intent = UUIDIntent()
//        let response = await handler.handle(intent: intent)
//
//        //XCTAssertEqual(response.code, .success)
//        XCTAssertEqual(response.uuidString, "some uuid")
//
//        self.wait(for: [expectation], timeout: 0.1)
//    }
//}
//
//private class UUIDUseCaseMock: UUIDUseCaseProtocol {
//    var _get: () -> String = { return "" }
//    func get() -> String {
//        return self._get()
//    }
//}
