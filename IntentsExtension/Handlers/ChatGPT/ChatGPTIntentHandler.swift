//
//  ChatGPTIntentHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 05/02/2023.
//

import Foundation
import Intents
import IntentsUseCases

final class ChatGPTIntentHandler: NSObject, ChatGPTIntentHandling {
   
    private let useCase: ChatGPTUseCaseProtocol

    init(useCase: ChatGPTUseCaseProtocol = ChatGPTUseCase()) {
        self.useCase = useCase
    }

    func handle(intent: ChatGPTIntent) async -> ChatGPTIntentResponse {
        guard
            let prompt = intent.prompt,
            let apiKey = intent.apiKey,
            let maxTokens = intent.maxTokens?.toUInt()
        else
        {
            return .init(code: .failure, userActivity: nil)
        }
        let configuration: ChatGPTConfiguration = .init(apiKey: apiKey,
                                                        maxToken: maxTokens)
        guard let useCaseResponse = await self.useCase.execute(prompt: prompt, configuration: configuration)
        else {
            return .init(code: .failure, userActivity: nil)
        }
        let response: ChatGPTIntentResponse = .init(code: .success, userActivity: nil)
        response.answer = useCaseResponse.answer
        return response
    }
    
    func resolvePrompt(for intent: ChatGPTIntent) async -> INStringResolutionResult {
        guard let prompt = intent.prompt else {
            return INStringResolutionResult.needsValue()
        }
        return INStringResolutionResult.success(with: prompt)
    }
}


private extension String {
    func toUInt() -> UInt? {
        return UInt(self)
    }
}
