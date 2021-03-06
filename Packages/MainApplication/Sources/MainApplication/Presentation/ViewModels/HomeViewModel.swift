//
//  HomeViewModel.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 05/01/2022.
//

import Foundation
import SwiftUI

protocol HomeViewModelable {
    var logoImageName: String { get }
    var title: String { get }
    var contributionTitle: String { get }
    func openContributionURL()
}

final class HomeViewModel: HomeViewModelable {
    let logoImageName: String = "logo"
    let title: String = "Open you Shortcuts app to use actions from\n1Intent"
    let contributionTitle: String = "Contribute on Github"

    private let contributionURL: URL? = .init(string: "https://github.com/1intent/ios-application")

    @Environment(\.openURL) private var openURL

    func openContributionURL() {
        guard let contributionURL = contributionURL else {
            return
        }
        self.openURL(contributionURL)
    }
}
