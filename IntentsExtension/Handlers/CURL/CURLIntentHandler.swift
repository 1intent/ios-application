//
//  CURLIntentHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 25/09/2023.
//

import Foundation
import Intents
import IntentsUseCases

final class CURLIntentHandler: NSObject, CURLIntentHandling {

    private let useCase: CURLUseCase

    init(useCase: CURLUseCase = CURLUseCaseImplementation()) {
        self.useCase = useCase
        super.init()
    }

    func handle(intent: CURLIntent) async -> CURLIntentResponse {
        guard let url = intent.url else {
            return .init(code: .failure, userActivity: nil)
        }


        guard let verb = CURLHTTPVerb(from: intent.httpVerb) else {
            return .init(code: .failure, userActivity: nil)
        }

        var dictionary = [String: String]()
        intent.headers?.forEach { header in
            guard let key = header.key, let value = header.value
            else { return }
            dictionary[key] = value
        }

        guard let result = await self.useCase.execute(with: url, verb: verb, headers: dictionary, body: intent.body)
        else {
            return .init(code: .failure, userActivity: nil)
        }

        let response: CURLIntentResponse = .init(code: .success, userActivity: nil)
        response.response = String(data: result, encoding: .utf8)
        return response
    }


}

private extension CURLHTTPVerb {

    init?(from verb: IntentHTTPVerb) {
        switch verb {
        case .get:
            self = .get
        case .delete:
            self = .delete
        case .post:
            self = .post
        case .put:
            self = .put
        default:
            return nil
        }
    }
}
