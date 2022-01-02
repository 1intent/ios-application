//
//  URLQueryUseCase.swift
//  
//
//  Created by Pierre Abi-aad on 02/01/2022.
//

import Foundation

public enum URLQueryUseCaseError: Error {
    case emptyArray
    case countMismatch
}
extension URLQueryUseCaseError: Equatable {}

public protocol URLQueryUseCaseProtocol {
    func invoke(keys: [String], values: [String]) throws -> String
}

public final class URLQueryUseCase: URLQueryUseCaseProtocol {

    public init() {}

    public func invoke(keys: [String], values: [String]) throws -> String {
        guard !keys.isEmpty, !values.isEmpty
        else {
            throw URLQueryUseCaseError.emptyArray
        }
        guard keys.count == values.count
        else {
            throw URLQueryUseCaseError.countMismatch
        }

        return Array(zip(keys, values))
            .map({ $0.0 + "=" + $0.1 })
            .joined(separator: "&")
    }
}
