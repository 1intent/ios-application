//
//  File.swift
//  
//
//  Created by Pierre Abi-aad on 21/07/2023.
//

import Foundation

public typealias URI = String

public enum URIEncodingUseCaseError: Error {
    case nilEncodeResult
}


extension URIEncodingUseCaseError: Equatable {}

public protocol URIEncodingUseCaseProtocol {
    func invoke(for uri: URI?) throws -> String
}

public final class URIEncodingUseCase: URIEncodingUseCaseProtocol {

    public init() {}

    public func invoke(for uri: URI?) throws -> String {
        guard let uri = uri
        else {
            return String()
        }
        guard let encodedString = uri.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            throw URIEncodingUseCaseError.nilEncodeResult
        }
        return encodedString
    }
}
