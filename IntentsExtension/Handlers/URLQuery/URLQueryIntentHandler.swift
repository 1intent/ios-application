//
//  URLQueryIntentHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 02/01/2022.
//

import Foundation
import IntentsUseCases

final class URLQueryIntentHandler: NSObject, URLQueryIntentHandling {

    private let useCase: URLQueryItemUseCaseProtocol

    init(useCase: URLQueryItemUseCaseProtocol = URLQueryItemUseCase()) {
        self.useCase = useCase
    }

    func handle(intent: URLQueryIntent) async -> URLQueryIntentResponse {
        let failureResponse: URLQueryIntentResponse = .init(code: .failure, userActivity: nil)
        guard
            let keys = intent.keys,
            let values = intent.values
        else {
            return failureResponse
        }

        do {
            let query = try self.useCase.invoke(keys: keys, values: values)
            let response: URLQueryIntentResponse = .init(code: .success, userActivity: nil)
            response.query = query
            return response
        } catch {
            return failureResponse
        }
    }
}
