//
//  File.swift
//  
//
//  Created by Pierre Abi-aad on 02/01/2022.
//

import Foundation

public enum TimeIntervalSinceOption {
    case year1970
    case now
    case referenceDate
    case date(Date)
}

public protocol TimeIntervalSinceUseCaseProtocol {
    func invoke(with date: Date, option: TimeIntervalSinceOption) -> TimeInterval
}

public final class TimeIntervalSinceUseCase: TimeIntervalSinceUseCaseProtocol {

    public init() {}

    public func invoke(with date: Date, option: TimeIntervalSinceOption) -> TimeInterval {
        switch option {
        case .year1970:
            return date.timeIntervalSince1970
        case .now:
            return date.timeIntervalSinceNow
        case .referenceDate:
            return date.timeIntervalSinceReferenceDate
        case .date(let otherDate):
            return date.timeIntervalSince(otherDate)

        }
    }
}
