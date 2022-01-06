//
//  HomeViewModelTests.swift
//  OpenActionsTests
//
//  Created by Pierre Abi-aad on 05/01/2022.
//

import XCTest
@testable import MainApplication

final class HomeViewModelTests: XCTestCase {

    func test_properties() {
        //GIVEN
        let viewModel = HomeViewModel()

        //WHEN...THEN
        XCTAssertEqual(viewModel.title, "Open you Shortcuts app to use actions from\nOpen Actions", "wrong title")
        XCTAssertEqual(viewModel.contributionTitle, "Contribute on Github", "wrong contributionTitle")
        XCTAssertEqual(viewModel.logoImageName, "logo", "wrong logoImageName")
    }
}
