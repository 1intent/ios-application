//
//  UUIDIntentHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

import Foundation
import IntentsUseCases

final class UUIDIntentHandler: NSObject, UUIDIntentHandling {

    private let useCase: UUIDUseCaseProtocol

    init(useCase: UUIDUseCaseProtocol = UUIDUseCase()) {
        self.useCase = useCase
        super.init()
    }

    func handle(intent: UUIDIntent) async -> UUIDIntentResponse {
        let response: UUIDIntentResponse = .init(code: .success, userActivity: nil)
        response.uuidString = self.useCase.get()
        return response
    }
}
