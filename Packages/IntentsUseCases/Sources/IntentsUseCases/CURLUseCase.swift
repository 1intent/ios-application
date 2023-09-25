//
//  File.swift
//  
//
//  Created by Pierre Abi-aad on 25/09/2023.
//

import Foundation

public typealias CURLHTTPHeaders = [String : String]

public enum CURLHTTPVerb {
    case get
    case post
    case delete
    case put

    public init?(fromRawValue input: String) {
        switch input.lowercased() {
        case "get":
            self = .get
        case "post":
            self = .post
        case "delete":
            self = .delete
        case "put":
            self = .put
        default:
            return nil
        }
    }

    var rawValue: String {
        switch self {
        case .get:
            return "get"
        case .post:
            return "post"
        case .delete:
            return "delete"
        case .put:
            return "put"
        }
    }
}

public protocol CURLUseCase {
    func execute(with url: URL, verb: CURLHTTPVerb, headers: CURLHTTPHeaders, body: String?) async -> Data?
}

public final class CURLUseCaseImplementation: CURLUseCase {

    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func execute(with url: URL, verb: CURLHTTPVerb, headers: CURLHTTPHeaders, body: String?) async -> Data? {

        var request = URLRequest(url: url)
        request.httpMethod = verb.rawValue
        if let body = body, let data = body.data(using: .utf8) {
            request.httpBody = data
            print(body)
        }
        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        do {
            let result = try await self.urlSession.data(for: request)
            return result.0
        } catch {
            return nil
        }
    }
}
