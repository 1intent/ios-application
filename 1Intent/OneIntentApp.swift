//
//  1IntentApp.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

import SwiftUI
import MainApplication

@main
struct OneIntentApp: App {
    var body: some Scene {
        WindowGroup {
            MainApplicationFactory.createHomeView()
        }
    }
}
