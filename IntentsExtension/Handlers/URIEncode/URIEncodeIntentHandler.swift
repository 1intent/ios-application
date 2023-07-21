//
//  URIEncodeIntentHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 21/07/2023.
//


import Foundation
import Intents
import IntentsUseCases

final class URIEncodeIntentHandler: NSObject, URIEncodeIntentHandling {

    private let useCase: URIEncodingUseCaseProtocol

    init(useCase: URIEncodingUseCaseProtocol = URIEncodingUseCase()) {
        self.useCase = useCase
        super.init()
    }

    func handle(intent: URIEncodeIntent) async -> URIEncodeIntentResponse {
        let response: URIEncodeIntentResponse = .init(code: .success, userActivity: nil)
        response.encodedURI = try? self.useCase.invoke(for: intent.value)
        return response
    }

    func resolveValue(for intent: URIEncodeIntent) async -> INStringResolutionResult {
        guard let value = intent.value else {
            return INStringResolutionResult.needsValue()
        }
        return INStringResolutionResult.success(with: value)
    }
}
