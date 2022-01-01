//
//  UUIDUseCase.swift
//  
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

import Foundation

public protocol UUIDUseCaseProtocol {
    func get() -> String
}

public final class UUIDUseCase: UUIDUseCaseProtocol {

    public init() {}

    public func get() -> String {
        return UUID().uuidString
    }
}
