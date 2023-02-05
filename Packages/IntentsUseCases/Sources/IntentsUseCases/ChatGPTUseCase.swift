//
//  ChatGPTUseCase.swift
//  
//
//  Created by Pierre Abi-aad on 05/02/2023.
//

import Foundation

public struct ChatGPTConfiguration {
    let apiKey: String
    let maxToken: UInt
    
    public init(apiKey: String, maxToken: UInt) {
        self.apiKey = apiKey
        self.maxToken = maxToken
    }
}

public struct ChatGPTResponse {
    public let answer: String
}

public protocol ChatGPTUseCaseProtocol {
    func execute(prompt: String, configuration: ChatGPTConfiguration) async -> ChatGPTResponse?
}

public final class ChatGPTUseCase: ChatGPTUseCaseProtocol {
    
    public init() {}
    
    public func execute(prompt: String, configuration: ChatGPTConfiguration) async -> ChatGPTResponse? {
        
        let body: APIRequestDTO = .init(model: "text-davinci-003", prompt: prompt, temperature: 0, maxTokens: configuration.maxToken)
        guard
            let url = URL(string: "https://api.openai.com/v1/completions"),
            let data = try? JSONEncoder().encode(body)
        else {
            return nil
        }
        var request: URLRequest = .init(url: url)
        request.setValue("Bearer \(configuration.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = data
        do {
            let apiResponse = try await URLSession.shared.data(for: request)
            let dto: APIResponseDTO = try JSONDecoder().decode(APIResponseDTO.self,
                                                               from: apiResponse.0)
            guard let answer = dto.choices.first?.text
            else {
                return nil
            }
            return .init(answer: answer)
        } catch {
            return nil
        }
    }
}

private struct APIRequestDTO: Encodable {
    let model: String
    let prompt: String
    let temperature: UInt
    let maxTokens: UInt
}


private struct APIResponseDTO: Decodable {
    let id: String
    let object: String
    let created: UInt
    let model: String
    let choices: [Choice]
    let usage: Usage

    struct Choice: Decodable {
        let text: String
        let index: Int
        let logprobs: String?
        let finishReason: String
    }

    struct Usage: Decodable {
        let promptTokens: UInt
        let completionTokens: UInt
        let totalTokens: UInt
    }
}
