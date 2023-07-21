//
//  URIEncodingUseCaseTests.swift
//  
//
//  Created by Pierre Abi-aad on 21/07/2023.
//

import IntentsUseCases
import XCTest

final class URIEncodingUseCaseTests: XCTestCase {

    func test() throws {
        let useCase = URIEncodingUseCase()
        let value = try XCTUnwrap(useCase.invoke(for: "https://api.datadoghq.com/api/v1/query?=sum:consumergoods.fsm.state.count{to:reserved,exit_code:success}.as_count()"))
    }
}
