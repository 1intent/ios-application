//
//  UUID.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 29/10/2023.
//

import Foundation
import AppIntents
@preconcurrency import IntentsUseCases

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct UUIDIntentHandler: AppIntent {

    static var title: LocalizedStringResource = "Generate UUID"
    static var description = IntentDescription("Generate an UUID (universally unique identifier)")

    static var parameterSummary: some ParameterSummary {
        Summary("Generate UUID")
    }

    private let useCase: UUIDUseCaseProtocol

    init() {
        self.useCase = UUIDUseCase()
    }

    init(useCase: UUIDUseCaseProtocol = UUIDUseCase()) {
        self.useCase = useCase
    }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let uuidString = self.useCase.get()
        return .result(value: uuidString)
    }
}


