//
//  DayBeforeTimestamp.swift
//
//
//  Created by Pierre Abi-aad on 30/05/2024.
//

import Foundation

public enum DayReference {
    case today
    case specific(Date)
}

public protocol DayBeforeTimestampUseCase: Sendable {
    func execute(reference: DayReference, startOfDay: Bool) -> TimeInterval
}

public final class DayBeforeTimestampUseCaseImpl: DayBeforeTimestampUseCase {

    public init() {}

    public func execute(reference: DayReference, startOfDay: Bool) -> TimeInterval {
        let date: Date
        switch reference {
        case .today:
            date = Date()
        case .specific(let specificDate):
            date = specificDate
        }

        let dayBefore = getDayBefore(date: date)
        let calendar = Calendar.current

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: dayBefore)

        if startOfDay {
            components.hour = 0
            components.minute = 0
            components.second = 0
            components.nanosecond = 0
        } else {
            components.hour = 23
            components.minute = 59
            components.second = 59
            components.nanosecond = 999999999
        }

        guard let modifiedDayBefore = calendar.date(from: components) else {
            return -1
        }
        return modifiedDayBefore.timeIntervalSince1970
    }
    
    private func getDayBefore(date: Date) -> Date {
        let calendar = Calendar.current
        guard let dayBefore = calendar.date(byAdding: .day, value: -1, to: date) else {
            return Date()
        }
        return dayBefore
    }
}
